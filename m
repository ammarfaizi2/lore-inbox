Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265987AbSLITMZ>; Mon, 9 Dec 2002 14:12:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265998AbSLITMX>; Mon, 9 Dec 2002 14:12:23 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:17924 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265987AbSLITMV>; Mon, 9 Dec 2002 14:12:21 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Dazed and Confused
Date: 9 Dec 2002 11:19:48 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <at2qck$ffi$1@cesium.transmeta.com>
References: <Pine.LNX.4.42.0212061133330.7770-100000@egg> <Pine.LNX.4.42.0212061202230.7770-100000@egg>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.42.0212061202230.7770-100000@egg>
By author:    Greg Boyce <gboyce@rakis.net>
In newsgroup: linux.dev.kernel
> 
> Actually, this does leave one question still:  How serious is the problem?
> How much would you trust a machine reporting these errors?  Most of the
> machines are just performing DNS and web service (although with a pretty
> high load).  The processes on the machine are are cpu and memory
> intensive, but there is no critical data stored on most of the machines.
> 
> Are the machines likely to give us problems with crashing and data
> corruption, or would it be safe to ignore the problem unless we started
> noticing odd behavior?
> 

The fact that you're seeing the error means data corruption has
already occurred.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
