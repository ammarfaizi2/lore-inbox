Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279035AbRKRMHl>; Sun, 18 Nov 2001 07:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279313AbRKRMHb>; Sun, 18 Nov 2001 07:07:31 -0500
Received: from AMontpellier-201-1-2-11.abo.wanadoo.fr ([193.253.215.11]:29446
	"EHLO awak") by vger.kernel.org with ESMTP id <S279035AbRKRMHV> convert rfc822-to-8bit;
	Sun, 18 Nov 2001 07:07:21 -0500
Subject: Re: [PATCH] devfs v196 available
From: Xavier Bestel <xavier.bestel@free.fr>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: Roman Zippel <zippel@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200111172116.fAHLGxS12195@vindaloo.ras.ucalgary.ca>
In-Reply-To: <200111031747.fA3Hl0u19223@vindaloo.ras.ucalgary.ca>
	<Pine.LNX.4.33.0111162035180.29140-100000@serv> 
	<200111172116.fAHLGxS12195@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/0.99.1+cvs.2001.11.14.09.00 (Preview Release)
Date: 18 Nov 2001 13:00:27 +0100
Message-Id: <1006084828.16011.0.camel@nomade>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

le sam 17-11-2001 à 22:16, Richard Gooch a écrit :
> Roman Zippel writes:
> > - symlink/slave handling of tapes/disk/cdroms is maybe better done
> >   in userspace.
> 
> No, because you want to be able to mount your root FS using
> "root=/dev/cdroms/cdrom0", for example.

"userspace" should probably be the "extended initrd" stuff we'll have in
2.5.

	Xav


