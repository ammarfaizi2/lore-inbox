Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317066AbSGCQYb>; Wed, 3 Jul 2002 12:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317068AbSGCQYa>; Wed, 3 Jul 2002 12:24:30 -0400
Received: from [213.4.129.129] ([213.4.129.129]:15202 "EHLO tsmtp6.mail.isp")
	by vger.kernel.org with ESMTP id <S317066AbSGCQY3>;
	Wed, 3 Jul 2002 12:24:29 -0400
Date: Wed, 3 Jul 2002 18:29:23 +0200
From: Diego Calleja <diegocg@teleline.es>
To: khromy@lnuxlab.ath.cx (khromy)
Cc: akpm@zip.com.au, linux-kernel@vger.kernel.org, ext3-users@redhat.com
Subject: Re: sync slowness. ext3 on VIA vt82c686b
Message-Id: <20020703182923.65e84356.diegocg@teleline.es>
In-Reply-To: <20020703043655.GA3346@lnuxlab.ath.cx>
References: <20020703022051.GA2669@lnuxlab.ath.cx>
	<3D226E86.695D27F3@zip.com.au>
	<20020703033538.GA3004@lnuxlab.ath.cx>
	<3D227621.B0A5C826@zip.com.au>
	<20020703040301.GA3233@lnuxlab.ath.cx>
	<20020703043655.GA3346@lnuxlab.ath.cx>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jul 2002 00:36:55 -0400
khromy@lnuxlab.ath.cx (khromy) escribió:
> I just tried with my Promise UDMA100 card with another cable and same 
> problem.  Any other ideas? Should I try rc1-aa1?

I'not an expert, but yes, why not try another kernel version, like
rc1-aa1 or the 2.5 tree?

You should run badblocks to see if there's something wrong in the disk,
but if you can't see any output from the kernel when yo try to copy the
file, I think this won't be the problem...



> 
> -- 
> L1:	khromy		;khromy(at)lnuxlab.ath.cx
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
