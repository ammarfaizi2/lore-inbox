Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262547AbSJ3D5Q>; Tue, 29 Oct 2002 22:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263280AbSJ3D5Q>; Tue, 29 Oct 2002 22:57:16 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:30475 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262547AbSJ3D5Q>; Tue, 29 Oct 2002 22:57:16 -0500
Date: Tue, 29 Oct 2002 20:03:33 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Incorrect 2.5.45 tar-balls created..
Message-ID: <Pine.LNX.4.44.0210291957330.1626-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There was, for a while, bogus 2.5.45 tar-balls etc created from a BK tree
that was never meant to be exported (translation: "Linus ran his automatic
release-scripts on a bad tree because he is a booger-head").

I've removed the offending files, and hopefully nobody even had time to
download them, but just in case - if you get your kernels as tar-balls (or 
as old-fashioned patches) rather than from the BK tree, and you saw a 
2.5.45, you should ignore it.

		Linus "booger-head" Torvalds

