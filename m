Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932226AbVL0FEx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbVL0FEx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 00:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932227AbVL0FEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 00:04:53 -0500
Received: from webbox4.loswebos.de ([213.187.93.205]:19927 "EHLO
	webbox4.loswebos.de") by vger.kernel.org with ESMTP id S932226AbVL0FEx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 00:04:53 -0500
Date: Tue, 27 Dec 2005 04:02:44 +0100
From: Marc Koschewski <marc@osknowledge.org>
To: Marc Koschewski <marc@osknowledge.org>
Cc: Jules Villard <jvillard@ens-lyon.fr>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Suspend to {mem,disk} broken in 2.6.15-rc6/rc7 on my T42
Message-ID: <20051227030243.GB5498@stiffy.osknowledge.org>
References: <20051226194527.GA3036@blatterie> <Pine.LNX.4.64.0512261201360.14098@g5.osdl.org> <20051226212339.GA9837@blatterie> <20051227025848.GA5498@stiffy.osknowledge.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051227025848.GA5498@stiffy.osknowledge.org>
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
X-Operating-System: Linux stiffy 2.6.15-rc7-marc-g04333393
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Marc Koschewski <marc@osknowledge.org> [2005-12-27 03:58:48 +0100]:

> Did you use the nVidia module? Several people reported machine hangs when
> doing the vt <-> X switching. This, however, should be fixed with the latest
> drivers.
> 
> I had the same problem some time ago. Though I knew a have reached a console
> where I was logged in the keyboard seems to deny any service when coming from X.
> Since i upgraded X to some CVS version and the nVidia driver 8174 (8178 working
> as well) anything is OK.
> 
> Marc

Doh! Damn tooooo late over here... I just managed to find some 'radeonfb'-like
string in your mail. :)

Good night,
     Marc
