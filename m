Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129050AbQKEKgx>; Sun, 5 Nov 2000 05:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129182AbQKEKgn>; Sun, 5 Nov 2000 05:36:43 -0500
Received: from rigel.cs.pdx.edu ([131.252.208.59]:48867 "EHLO rigel.cs.pdx.edu")
	by vger.kernel.org with ESMTP id <S129050AbQKEKga>;
	Sun, 5 Nov 2000 05:36:30 -0500
Date: Sun, 5 Nov 2000 02:36:27 -0800 (PST)
From: Naren Devaiah <naren@cs.pdx.edu>
To: linux-kernel@vger.kernel.org
Subject: Where is __this_module actually defined?
Message-ID: <Pine.GSO.4.21.0011050231120.2808-100000@antares.cs.pdx.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've looked in the 2.4.0-pre10 source tree and found it defined as 
	extern struct module __this_module;
in module.h (among other files), but where is it actually defined?

TIA,
Naren

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
