Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281809AbSAGRUr>; Mon, 7 Jan 2002 12:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281916AbSAGRUk>; Mon, 7 Jan 2002 12:20:40 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:17672 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S281809AbSAGRUX>; Mon, 7 Jan 2002 12:20:23 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: 2.5 suggestion
Date: 7 Jan 2002 09:19:52 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a1clbo$38m$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.4.43.0201071317340.8864-100000@tchiwam2.invers.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.43.0201071317340.8864-100000@tchiwam2.invers.fi>
By author:    Philippe Trottier <tchiwam@invers.fi>
In newsgroup: linux.dev.kernel
>
> To prevent big confusion after adding or removing hardware (IDE, SCSI,
> Network) would it be possible to assign them an order of detection or
> give them a fixed Major / minor ?
> 

There is no such order possible.  Really.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
