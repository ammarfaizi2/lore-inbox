Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281492AbRKHJVw>; Thu, 8 Nov 2001 04:21:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281486AbRKHJVl>; Thu, 8 Nov 2001 04:21:41 -0500
Received: from mail.gmx.net ([213.165.64.20]:29691 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S281499AbRKHJVb>;
	Thu, 8 Nov 2001 04:21:31 -0500
Date: Thu, 8 Nov 2001 10:21:24 +0100
From: Jonas Diemer <diemer@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: VIA 686 timer bugfix incomplete
Message-Id: <20011108102124.31ca040f.diemer@gmx.de>
In-Reply-To: <20011108090215.G3708@suse.cz>
In-Reply-To: <20011107211445.A2286@suse.cz>
	<Pine.LNX.4.05.10111080917140.19515-100000@marina.lowendale.com.au>
	<20011108090215.G3708@suse.cz>
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, then maybe Vojtech's suggestion is best: use RTC for timing, not the
chipset...
as to my knowledge, every i38 system has a standard RTC, so why not use this? or
even better: make an option in the config to choose whether use RTC or the
chipset.

-jonas

PS: CC me in your answers, plz.
