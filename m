Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288112AbSAMUUg>; Sun, 13 Jan 2002 15:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288113AbSAMUU0>; Sun, 13 Jan 2002 15:20:26 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:33041 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S288112AbSAMUUW>; Sun, 13 Jan 2002 15:20:22 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: F00F-bug workaround working?
Date: 13 Jan 2002 12:20:10 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a1sq5q$nb7$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0201122347270.16871-100000@blueberrysolutions.com> <20020112160308.B4926@ksu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20020112160308.B4926@ksu.edu>
By author:    Joseph Pingenot <jap3003@ksu.edu>
In newsgroup: linux.dev.kernel
>
> From Tony Glader on Saturday, 12 January, 2002:
> >I have had problems with 2.4.17 running in a Classic Pentium (lot of 
> >oopses). I'm sure that there's no problem with hardware. Is F00F'bug 
> >workaround work still?
> 
> I'm running a P100 on 2.4.17 without any errors.  I see
> "Intel Pentium with F0 0F bug - workaround enabled."
> in the dmesg logs.
> 
> How about posting your oopses (after running them through ksymoops)
> 

F00F wouldn't oops the machine anyway, it would lock it up solid.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
