Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129112AbRBTEai>; Mon, 19 Feb 2001 23:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129193AbRBTEa2>; Mon, 19 Feb 2001 23:30:28 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:28941 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129112AbRBTEaR>; Mon, 19 Feb 2001 23:30:17 -0500
Message-ID: <3A91F2BB.A5D5D34F@transmeta.com>
Date: Mon, 19 Feb 2001 20:29:47 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Paul Gortmaker <p_gortmaker@yahoo.com>
CC: Scott Long <smlong@teleport.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux OS boilerplate
In-Reply-To: <3A902F77.8BF6AB52@teleport.com> <3A90E16D.DB868F2@yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Gortmaker wrote:
> 
> Scott Long wrote:
> >
> > I've been poring over the x86 boot code for a while now and I've been
> > considering writing a FAQ on the boot process (mostly for my own use,
> 
> [...]
> 
> > Does there exist an outline (detailed or not) of the boot process from
> > the point of BIOS bootsector load to when the kernel proper begins
> 
> IIRC, there is some useful info contained within loadlin.  Also, I
> found a doc by hpa called "THE LINUX/I386 BOOT PROTOCOL" in my local
> archive of cruft -  I just assumed it was in Documentation/ but
> apparently it never made it there (yet).
> 

It's in there (Documentation/i386/boot.txt).

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
