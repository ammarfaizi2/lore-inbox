Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263325AbUBEKJb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 05:09:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264604AbUBEKJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 05:09:31 -0500
Received: from mail008.syd.optusnet.com.au ([211.29.132.212]:65169 "EHLO
	mail008.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S263325AbUBEKJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 05:09:29 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.6.2-ck1
Date: Thu, 5 Feb 2004 21:09:07 +1100
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200402052109.24122.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Updated patchset:

Full description, downloads and split patches:
http://kernel.kolivas.org


Changes:
O21int is in mainline now

Added supermount-ng v 2.0.4

Tiny update to htbatch code

Cleanup patches to separate easier again.


Summary:
am6
Autoregulates the virtual memory swappiness.

batch7
Batch scheduling.

iso1
Isochronous scheduling.

htbase1
Base patch for hyperthread modifications

httweak1
Tiny performance enhancements for hyperthreading

htnice2
Make "nice" hyperthread smart

htbatch2
Make batch scheduling hyperthread smart

cfqioprio
Complete Fair Queueing disk scheduler and I/O priorities

schedioprio
Set initial I/O priorities according to cpu scheduling policy and nice

sng204
Supermount-NG v2.0.4


Planned:
Nick's memory pressure VM tweaks
Updated CFQ and I/O prio patches from Jens (when available).


Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAIhZFZUg7+tp6mRURAjNRAJ4iqzmxteyE/jVZGkDvFiPuJNtUtwCeMnV4
eBGsxcPqFRkITSreUZDrP7M=
=OoLO
-----END PGP SIGNATURE-----
