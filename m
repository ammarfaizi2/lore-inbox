Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265632AbSKDNFk>; Mon, 4 Nov 2002 08:05:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265991AbSKDNFk>; Mon, 4 Nov 2002 08:05:40 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:63887 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265632AbSKDNFj>; Mon, 4 Nov 2002 08:05:39 -0500
Subject: Re: swsusp: don't eat ide disks
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: benh@kernel.crashing.org
Cc: Pavel Machek <pavel@ucw.cz>, Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021104081624.27128@smtp.wanadoo.fr>
References: <1036367813.30679.40.camel@irongate.swansea.linux.org.uk> 
	<20021104081624.27128@smtp.wanadoo.fr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 04 Nov 2002 13:33:47 +0000
Message-Id: <1036416827.1113.29.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-11-04 at 08:16, benh@kernel.crashing.org wrote:
> Also, I know at least of one nasty device here that won't play
> nice unless it gets the identify command after reset (special
> hacked device that lies about it's device type, a ZIP that
> masquerades as an IDE-CD, to workaround firmware bugs in some
> older laptops, ugh !)

And old old quantum drives a few of which if I remember rightly were not
averse to doing one or two command types before the disk head reached
speed

