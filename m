Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314143AbSDZTyU>; Fri, 26 Apr 2002 15:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314144AbSDZTyT>; Fri, 26 Apr 2002 15:54:19 -0400
Received: from mailhost2.teleline.es ([195.235.113.141]:36689 "EHLO
	tsmtp6.mail.isp") by vger.kernel.org with ESMTP id <S314143AbSDZTyS>;
	Fri, 26 Apr 2002 15:54:18 -0400
Date: Fri, 26 Apr 2002 21:56:41 +0200
From: Diego Calleja <DiegoCG@teleline.es>
To: mcp@linux-systeme.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.18 and strange OOM Killer behaveness
Message-Id: <20020426215641.5bb93131.DiegoCG@teleline.es>
In-Reply-To: <200204261636.14573.mcp@linux-systeme.de>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Apr 2002 16:38:08 +0200
Marc-Christian Petersen <mcp@linux-systeme.de> escribió:

> I also tried this with rmap enabled kernel, no OOM Messages appears, but the 
> system freezes. It does NOT accept any input on keyboard, mouse or via the 
> network (e.g ping, traceroute, telnet to smtp port etc.). Also, if the system 
> does not accept any input, the harddisk is doing something, i've waited ~ 45 
> minutes, system was still not accepting anything, harddisk was doing 
> anything. This was rmap12h with 2.4.18.

I guess it should be better to OOM here...?

> -- 
> Kind regards
> 	Marc-Christian Petersen
> 
> http://sourceforge.net/projects/wolk
> 
> PGP/GnuPG Key: 1024D/569DE2E3DB441A16
> Fingerprint: 3469 0CF8 CA7E 0042 7824  080A 569D E2E3 DB44 1A16
> Key available at wwwkeys.pgp.net.   Encrypted e-mail preferred.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
