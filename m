Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262252AbRERGPf>; Fri, 18 May 2001 02:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262253AbRERGPZ>; Fri, 18 May 2001 02:15:25 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:2576 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262252AbRERGPL>; Fri, 18 May 2001 02:15:11 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Linux OS boilerplate
Date: 17 May 2001 23:14:53 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9e2ekt$3ua$1@cesium.transmeta.com>
In-Reply-To: <3A902F77.8BF6AB52@teleport.com> <3A90E16D.DB868F2@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3A90E16D.DB868F2@yahoo.com>
By author:    Paul Gortmaker <p_gortmaker@yahoo.com>
In newsgroup: linux.dev.kernel
> 
> > Does there exist an outline (detailed or not) of the boot process from
> > the point of BIOS bootsector load to when the kernel proper begins
> 
> IIRC, there is some useful info contained within loadlin.  Also, I
> found a doc by hpa called "THE LINUX/I386 BOOT PROTOCOL" in my local
> archive of cruft -  I just assumed it was in Documentation/ but
> apparently it never made it there (yet).
> 

Documentation/i386/boot.txt

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
