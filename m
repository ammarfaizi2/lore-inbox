Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265691AbTFXFMe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 01:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265693AbTFXFMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 01:12:34 -0400
Received: from stingr.net ([212.193.32.15]:1438 "EHLO hq.stingr.net")
	by vger.kernel.org with ESMTP id S265691AbTFXFMd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 01:12:33 -0400
Date: Tue, 24 Jun 2003 09:26:39 +0400
From: Paul P Komkoff Jr <i@stingr.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [Q] loop.c
Message-ID: <20030624052639.GB23657@stingr.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <UTC200306230127.h5N1RpE13973.aeb@smtp.cwi.nl> <20030623161430.GA23657@stingr.net> <20030624012729.A1133@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20030624012729.A1133@pclin040.win.tue.nl>
User-Agent: Agent Darien Fawkes
X-Mailer: Intel Ultra ATA Storage Driver
X-RealName: Stingray Greatest Jr
Organization: Department of Fish & Wildlife
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Replying to Andries Brouwer:
> These patches make lo_offset a loff_t.

ioctls are still passing 32bit value?

- -- 
Paul P 'Stingray' Komkoff Jr // http://stingr.net/key <- my pgp key
 This message represents the official view of the voices in my head
-----BEGIN PGP SIGNATURE-----

iD8DBQE+9+EKyMW8naS07KQRAr6wAKDEzItu+8ZSaLODV7RO5WgZ4UAcYgCfZZsh
PGFhBGvkbRWd3oDHpbbVWc8=
=cWKH
-----END PGP SIGNATURE-----
