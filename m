Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267287AbUJBFdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267287AbUJBFdZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 01:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267294AbUJBFdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 01:33:25 -0400
Received: from mx1.redhat.com ([66.187.233.31]:62877 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267287AbUJBFdP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 01:33:15 -0400
Message-ID: <415E3D5A.2010501@redhat.com>
Date: Fri, 01 Oct 2004 22:32:10 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a4) Gecko/20040927
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: George Anzinger <george@mvista.com>, johnstul@us.ibm.com,
       Ulrich.Windl@rz.uni-regensburg.de, jbarnes@sgi.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, libc-alpha@sources.redhat.com
Subject: Re: Posix compliant cpu clocks V6 [2/3]: Glibc patch
References: <B6E8046E1E28D34EB815A11AC8CA312902CD3264@mtv-atc-605e--n.corp.sgi.com> <Pine.LNX.4.58.0409240508560.5706@schroedinger.engr.sgi.com> <4154F349.1090408@redhat.com> <Pine.LNX.4.58.0409242253080.13099@schroedinger.engr.sgi.com> <41550B77.1070604@redhat.com> <B6E8046E1E28D34EB815A11AC8CA312902CD327E@mtv-atc-605e--n.corp.sgi.com> <Pine.LNX.4.58.0409271344220.32308@schroedinger.engr.sgi.com> <4159B920.3040802@redhat.com> <Pine.LNX.4.58.0409282017340.18604@schroedinger.engr.sgi.com> <415AF4C3.1040808@mvista.com> <B6E8046E1E28D34EB815A11AC8CA31290322B307@mtv-atc-605e--n.corp.sgi.com> <Pine.LNX.4.58.0410011259190.18738@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.58.0410011259190.18738@schroedinger.engr.sgi.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Christoph Lameter wrote:
> The following patch makes glibc not provide the above clocks and use the
> kernel clocks instead if either of the following condition is met:

Did you ever hear about a concept called binary compatiblity?  Don't
bother working on any glibc patch.

- --
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBXj1a2ijCOnn/RHQRAh31AJ9rZ5+i5x3LkTwEbeMj2DY/uBzPjwCfeAip
zTYpRJb0lfsR5POro22uViM=
=aUP/
-----END PGP SIGNATURE-----
