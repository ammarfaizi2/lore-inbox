Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274064AbRJTTwF>; Sat, 20 Oct 2001 15:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274162AbRJTTvz>; Sat, 20 Oct 2001 15:51:55 -0400
Received: from pcow034o.blueyonder.co.uk ([195.188.53.122]:4110 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S274064AbRJTTvu>;
	Sat, 20 Oct 2001 15:51:50 -0400
Content-Type: text/plain; charset=US-ASCII
From: Alan Chandler <alan@chandlerfamily.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: Unresolved symbol hotplug_path in usbcore.o as a module (2.4.12)
Date: Sat, 20 Oct 2001 20:52:22 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <29038.1003562736@ocs3.intra.ocs.com.au>
In-Reply-To: <29038.1003562736@ocs3.intra.ocs.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E15v2AR-0000no-00@roo.home>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Saturday 20 October 2001 8:25 am, Keith Owens wrote:
> On Sat, 20 Oct 2001 08:12:14 +0100,
>
> Alan Chandler <alan@chandlerfamily.org.uk> wrote:
> >alan@kanger:/$ grep hotplug_path /proc/ksyms System.map
> >/proc/ksyms:c0290960 hotplug_path_R__ver_hotplug_path
>
> Bingo!  http://www.tux.org/lkml/#s8-8

Thanks - solved.  I've read the FAQ several times but not groked that bit.  

- -- 

  Alan - alan@chandlerfamily.org.uk
http://www.chandlerfamily.org.uk
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE70dX21mf3M5ZDr2kRAr9vAKDFJzsZmKjAQqVwlOTJQocPxiLmHQCdErMh
rancatzCVIKXgdVyUMOZArA=
=MPcM
-----END PGP SIGNATURE-----
