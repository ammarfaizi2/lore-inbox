Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262117AbVFUPUs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262117AbVFUPUs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 11:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbVFUPSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 11:18:39 -0400
Received: from 238-071.adsl.pool.ew.hu ([193.226.238.71]:59662 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262117AbVFUPR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 11:17:59 -0400
To: john@stoffel.org
CC: pavel@ucw.cz, miklos@szeredi.hu, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-reply-to: <17080.10589.619933.883739@smtp.charter.net> (john@stoffel.org)
Subject: Re: -mm -> 2.6.13 merge status (fuse)
References: <20050620235458.5b437274.akpm@osdl.org>
	<E1Dkfu2-0005Ju-00@dorka.pomaz.szeredi.hu>
	<20050621142820.GC2015@openzaurus.ucw.cz> <17080.10589.619933.883739@smtp.charter.net>
Message-Id: <E1DkkV9-0005nN-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 21 Jun 2005 17:17:23 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'd like to see FUSE merged too, even without user mounts, if only to
> get more motivated to actually play with this and see how it works.

You can try it out now.  Download from fuse.sf.net, ./configure; make;
make install.  It's not as if it was harder than compiling a kernel :)

Miklos
