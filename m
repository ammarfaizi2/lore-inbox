Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315593AbSGFPGj>; Sat, 6 Jul 2002 11:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315595AbSGFPGi>; Sat, 6 Jul 2002 11:06:38 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:3851 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S315593AbSGFPGh>;
	Sat, 6 Jul 2002 11:06:37 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: kbuild-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Announce: Kernel Build for 2.5, release 3.1 is available 
In-Reply-To: Your message of "Mon, 24 Jun 2002 22:09:35 +1000."
             <7587.1024920575@ocs3.intra.ocs.com.au> 
Date: Sun, 07 Jul 2002 01:08:51 +1000
Message-ID: <30724.1025968131@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

On Mon, 24 Jun 2002 22:09:35 +1000, 
Keith Owens <kaos@ocs.com.au> wrote:
>Release 3.1 of kernel build for kernel 2.5 (kbuild 2.5) is available.
>http://sourceforge.net/projects/kbuild/, package kbuild-2.5, download
>release 3.1.

New files:

kbuild-2.5-core-21
  Changes from core-20

  make mrproper updates.
  Tweak order of generated include files.
  Tweak pp_makefile4 -n processing.
  Handle targets that are not known until phase5.

kbuild-2.5-common-2.5.25-1
kbuild-2.5-i386-2.5.25-1

  Upgrade to 2.5.25.
  Correct lib/zlib_{in,de}flate rules (Jak).
  DocBook cleanups (Jak, KAO).

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE9Jwf2i4UHNye0ZOoRAgrBAKCvISmZFVF93/nW4RFCbBeeAAn7UwCfVtfu
FxBFSiXaF+mAErsHBfREn9c=
=bMhP
-----END PGP SIGNATURE-----

