Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267662AbUH1TaD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267662AbUH1TaD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 15:30:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267660AbUH1TaD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 15:30:03 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:41405 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S267653AbUH1T3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 15:29:55 -0400
Date: Sat, 28 Aug 2004 19:42:11 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, grendel@caudium.net,
       "Nemosoft Unv." <webcam@smcc.demon.nl>,
       Linus Torvalds <torvalds@osdl.org>, Craig Milo Rogers <rogers@isi.edu>,
       Xavier Bestel <xavier.bestel@free.fr>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: Termination of the Philips Webcam Driver (pwc)
Message-ID: <20040828174211.GA505@openzaurus.ucw.cz>
References: <20040826233244.GA1284@isi.edu> <200408272342.30619@smcc.demon.nl> <20040827224937.GA5107@beowulf.thanes.org> <200408271840.04219.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408271840.04219.dtor_core@ameritech.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I wonder if something like uinput is possible/desirable for v4l?


It would certainly be nice (taking streamed video from net and feeding it
to your favouite application?)

Something like jack would be even nicer,
but that's off-topic for l-k.
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

