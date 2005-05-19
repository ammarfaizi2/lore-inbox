Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262507AbVESPi5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262507AbVESPi5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 11:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262518AbVESPi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 11:38:57 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:5646 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262507AbVESPiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 11:38:55 -0400
Message-Id: <200505191510.j4JFAMlv000691@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Takashi Iwai <tiwai@suse.de>, Karel Kulhavy <clock@twibright.com>,
       Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
Subject: Re: software mixing in alsa 
In-Reply-To: Your message of "Wed, 18 May 2005 16:38:01 +0200."
             <428B5349.5090207@drzeus.cx> 
From: Valdis.Kletnieks@vt.edu
References: <20050517095613.GA9947@kestrel> <200505171208.04052.jan@spitalnik.net> <20050517141307.GA7759@kestrel> <1116354762.31830.12.camel@mindpipe> <20050517192412.GA19431@kestrel.twibright.com> <200505172027.j4HKRjTV029545@turing-police.cc.vt.edu> <s5hll6csl0b.wl@alsa2.suse.de>
            <428B5349.5090207@drzeus.cx>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1116515413_10388P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 19 May 2005 11:10:19 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1116515413_10388P
Content-Type: text/plain; charset=us-ascii

On Wed, 18 May 2005 16:38:01 +0200, Pierre Ossman said:

> I'd beg to differ. I have to apply the patch made by you to avoid
> getting a lot of distortions with esound and dmix:
> 
> http://bugzilla.gnome.org/show_bug.cgi?id=140803
> 
> Checking in the cvs, this still hasn't been commited.

I owe Takashi a beer for creating the patch, and Pierre for bringing it
to my attention - it solves the issue I was seeing on Fedora Core where
alsa 1.0.9rc2 was hosing up esd.

--==_Exmh_1116515413_10388P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCjKxHcC3lWbTT17ARAnGmAJ9dFPlmMqVQMOo6MywqcvHZGGrqkwCghuOV
y06TaB8sIGnr6ZRGDYN1O/A=
=CTYc
-----END PGP SIGNATURE-----

--==_Exmh_1116515413_10388P--
