Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278841AbRKDVNs>; Sun, 4 Nov 2001 16:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278958AbRKDVNk>; Sun, 4 Nov 2001 16:13:40 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:25096 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S278841AbRKDVNY>; Sun, 4 Nov 2001 16:13:24 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Compile problem with pre-8 (CRAMFS)
Date: 4 Nov 2001 13:12:54 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9s4b0m$ded$1@cesium.transmeta.com>
In-Reply-To: <3BE59CE5.8000607@candelatech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3BE59CE5.8000607@candelatech.com>
By author:    Ben Greear <greearb@candelatech.com>
In newsgroup: linux.dev.kernel
> 
> Seems to be an issue with cramfs in pre-8.  My .config is attached.
> 

ftp://ftp.kernel.org/pub/linux/kernel/people/hpa/zisofs-2.4.14-pre8.diff

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
