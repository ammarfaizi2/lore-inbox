Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265134AbTANTxi>; Tue, 14 Jan 2003 14:53:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265135AbTANTxi>; Tue, 14 Jan 2003 14:53:38 -0500
Received: from 60.54.252.64.snet.net ([64.252.54.60]:39515 "EHLO
	mail.blue-labs.org") by vger.kernel.org with ESMTP
	id <S265134AbTANTxg>; Tue, 14 Jan 2003 14:53:36 -0500
Message-ID: <3E246CCF.9090505@blue-labs.org>
Date: Tue, 14 Jan 2003 15:02:23 -0500
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030110
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Kconfig broken in 2.5.58?
X-Enigmail-Version: 0.71.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Bmilter: Processing completed, Bmilter version 0.1.1 build 905; timestamp 2003-01-14 15:02:29, message serial number 726063
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

root      1984 11.1 62.9 167388 160056 pts/0 D    11:48   0:06 
./scripts/kconfig

Ehm....160+ megs of ram and 11% cpu?  This is a P4-2.0Ghz machine.  It 
eventually settles down but even starting up with that much ram load is 
awful.

David

- -- 
I may have the information you need and I may choose only HTML.  It's up to you. Disclaimer: I am not responsible for any email that you send me nor am I bound to any obligation to deal with any received email in any given fashion.  If you send me spam or a virus, I may in whole or part send you 50,000 return copies of it. I may also publically announce any and all emails and post them to message boards, news sites, and even parody sites.  I may also mark them up, cut and paste, print, and staple them to telephone poles for the enjoyment of people without internet access.  This is not a confidential medium and your assumption that your email can or will be handled confidentially is akin to baring your backside, burying your head in the ground, and thinking nobody can see you butt nekkid and in plain view for miles away.  Don't be a cluebert, buy one from K-mart today.

When it absolutely, positively, has to be destroyed overnight.
                           AIR FORCE

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE+JGzS74cGT/9uvgsRAlXCAKDgOhHldbBBknBVF+t7W1ahewJGcgCdHqJD
GpCLUnGrma7WO0ngqGeAxjE=
=1F0w
-----END PGP SIGNATURE-----

