Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130532AbRDYSJp>; Wed, 25 Apr 2001 14:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130768AbRDYSJf>; Wed, 25 Apr 2001 14:09:35 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:59914 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130532AbRDYSJa>; Wed, 25 Apr 2001 14:09:30 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Device Registry (DevReg) Patch 0.2.0
Date: 25 Apr 2001 11:09:16 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9c73sc$uds$1@cesium.transmeta.com>
In-Reply-To: <3AE704FA.DCF1BEC6@kegel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3AE704FA.DCF1BEC6@kegel.com>
By author:    Dan Kegel <dank@kegel.com>
In newsgroup: linux.dev.kernel
> 
> The only problem with /proc as it stands is that there is no formal
> syntax for its entries.  Some of them are hard to parse.
> 

/proc/sys is probably the method to follow.  Every item is a datum of
a simple datatype.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
