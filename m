Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266717AbTAAEGs>; Tue, 31 Dec 2002 23:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266763AbTAAEGs>; Tue, 31 Dec 2002 23:06:48 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:16295 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S266717AbTAAEGr>; Tue, 31 Dec 2002 23:06:47 -0500
Message-ID: <3E126B33.7000807@iku-ag.de>
Date: Wed, 01 Jan 2003 05:14:43 +0100
From: Kurt Huwig <k.huwig@iku-ag.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021016
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Oops with 2.4.20 when accessing SVCDs
References: <3E11B976.3010306@iku-ag.de> <200301010150.13274.m.c.p@wolk-project.de>
In-Reply-To: <3E11B976.3010306@iku-ag.de>
X-Enigmail-Version: 0.70.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Marc-Christian Petersen wrote:

| On Tuesday 31 December 2002 16:36, Kurt Huwig wrote:
|
|> I got the attached oops when copying a file from a SVCD using
|> cdfs-0.5c I mounted a SVCD using mount -t cdfs /dev/cdbrenner
|> /cdbrenner using the cdfs driver from
|> http://www.elis.rug.ac.be/~ronsse/cdfs/cdfs.html
|
| Can you reproduce this w/o cdfs? I've heard alot of problems with
| cdfs is oopsing and crashing with recent kernels so this might be a
| problem of cdfs, not the kernel itself.

Without cdfs, I don't know how to access SVCDs ;-) Images of "normal"
CDs work fine.

Kurt
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE+EmsyTDL5CJndlGgRAly0AKDiYdySKrd9BjjvyraEbnCSoj5KOACfdNx8
HXytM2/pTawxXZeKyWcurcA=
=Yp1F
-----END PGP SIGNATURE-----

