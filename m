Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265044AbTFCPQO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 11:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265045AbTFCPQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 11:16:14 -0400
Received: from bork.hampshire.edu ([206.153.194.35]:51678 "EHLO
	bork.hampshire.edu") by vger.kernel.org with ESMTP id S265044AbTFCPQL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 11:16:11 -0400
Date: Tue, 3 Jun 2003 11:29:39 -0400 (EDT)
From: "Wm. Josiah Erikson" <josiah@insanetechnology.com>
X-X-Sender: josiah@bork.hampshire.edu
To: Bob Johnson <livewire@gentoo.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: siimage driver status
In-Reply-To: <200306031013.17835.livewire@gentoo.org>
Message-ID: <Pine.LNX.4.44.0306031127450.23499-100000@bork.hampshire.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does this still happen? It used to happen to me, but as soon as I added 
-X66, per Alan's suggestion, everything is fine.
	-Josiah (currently in the middle of writing 36GB to a two-drive 
RAID 0 array on a sil3112 controller and everything is peachy - fast as 
HELL, actually - grin - I've never seen over 100MB/sec off a RAID 0 of two 
drives before)


On Tue, 3 Jun 2003, Bob Johnson wrote:

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Has anything been addressed to help the instant lock up when enabling dma 
that alot of users are reporting?

