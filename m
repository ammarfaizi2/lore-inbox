Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261923AbSIPOAW>; Mon, 16 Sep 2002 10:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261944AbSIPOAV>; Mon, 16 Sep 2002 10:00:21 -0400
Received: from line106-15.adsl.actcom.co.il ([192.117.106.15]:23694 "EHLO
	www.veltzer.org") by vger.kernel.org with ESMTP id <S261923AbSIPOAV>;
	Mon, 16 Sep 2002 10:00:21 -0400
Message-Id: <200209161416.g8GEGNH02280@www.veltzer.org>
Content-Type: text/plain;
  charset="iso-8859-15"
From: Mark Veltzer <mark@veltzer.org>
Organization: Meta Ltd.
To: Xavier Bestel <xavier.bestel@free.fr>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Hi is this critical??
Date: Mon, 16 Sep 2002 17:16:10 +0300
X-Mailer: KMail [version 1.3.2]
References: <Pine.LNX.4.43.0209161537200.5180-100000@cibs9.sns.it> <1032184041.7199.14.camel@bip>
In-Reply-To: <1032184041.7199.14.camel@bip>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Monday 16 September 2002 16:47, Xavier Bestel wrote:
> Le lun 16/09/2002 à 15:37, venom@sns.it a écrit :
> > yes, this is critical.
> > It means that your HD is going to break soon.
>
> Maybe these error messages should be a bit less cryptic for the
> uninitiated. Or is there a userspace utility to convert theses to
> luser-understandable messages ?

1. No user-space utility exists/will exist for that (it will only make 
maintaince of the kernel a bigger problem than it is today as there will be a 
need to sync the two systems and since messages change all the time and there 
is no standard format for error message which is strictly adhered too then 
this is a much bigger problem than you talk about).

2. The user who posted the question is under no circumstances a "looser" 
(mind the oo instead of the u...). His question is very valid and the fact 
that he read dmesg puts him way past any standard computer user.

3. I don't think it is appropriate to call him with such a name and it even 
hurts kernel development as it makes him (and other people that are watching 
the list) abstain from submitting questions. While some of the questions are 
not the interest of this list they could be politely told so but we do NOT 
want to lose the really interesting bits (some user with a special IDE setup 
that does not work and will be afraid to report the messages he's getting on 
the ground of being called a looser).

Mark.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9heeqxlxDIcceXTgRAkYcAJ9OlVd2xUvH+ZAVM5Nwdv7umKHGiACggBYK
nmnRud3bf8NGq9OcDhuGUWY=
=oliB
-----END PGP SIGNATURE-----
