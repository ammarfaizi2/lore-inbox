Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264881AbTFWQBW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 12:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264795AbTFWQBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 12:01:22 -0400
Received: from stingr.net ([212.193.32.15]:58524 "EHLO hq.stingr.net")
	by vger.kernel.org with ESMTP id S264806AbTFWQAZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 12:00:25 -0400
Date: Mon, 23 Jun 2003 20:14:30 +0400
From: Paul P Komkoff Jr <i@stingr.net>
To: linux-kernel@vger.kernel.org
Subject: [Q] loop.c
Message-ID: <20030623161430.GA23657@stingr.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <UTC200306230127.h5N1RpE13973.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <UTC200306230127.h5N1RpE13973.aeb@smtp.cwi.nl>
User-Agent: Agent Darien Fawkes
X-Mailer: Intel Ultra ATA Storage Driver
X-RealName: Stingray Greatest Jr
Organization: Department of Fish & Wildlife
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Replying to Andries.Brouwer@cwi.nl:
> Below a patch for loop.[ch]. It can be applied.

Please, can anybody review the possibility of making offset LARGEFILE-capable?
I was stuck in it couple of time, yes, not yet understood what actually
happening inside loop.c to just blindly add new ioctl and do loff_t
internally.

Maybe I'm too stupid for this and it have more elegant solution than coding
what I've said ...

- -- 
Paul P 'Stingray' Komkoff Jr // http://stingr.net/key <- my pgp key
 This message represents the official view of the voices in my head
-----BEGIN PGP SIGNATURE-----

iD8DBQE+9ydlyMW8naS07KQRAiocAKCVSom0DtFtvEb3bbeWY1uda2iJkgCgu8E2
IoAERy2wzdhbc2Q5Z7zpFqs=
=DbIz
-----END PGP SIGNATURE-----
