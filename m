Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262882AbREVXDB>; Tue, 22 May 2001 19:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262883AbREVXCv>; Tue, 22 May 2001 19:02:51 -0400
Received: from pizda.ninka.net ([216.101.162.242]:50311 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262882AbREVXCl>;
	Tue, 22 May 2001 19:02:41 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15114.61452.980945.315535@pizda.ninka.net>
Date: Tue, 22 May 2001 16:02:36 -0700 (PDT)
To: Pavel Machek <pavel@suse.cz>
Cc: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <andrewm@uow.edu.au>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: Re: alpha iommu fixes
In-Reply-To: <20010522151143.A9541@bug.ucw.cz>
In-Reply-To: <20010519231131.A2840@jurassic.park.msu.ru>
	<20010520044013.A18119@athlon.random>
	<3B07AF49.5A85205F@uow.edu.au>
	<20010520154958.E18119@athlon.random>
	<20010520181803.I18119@athlon.random>
	<3B07EEFE.43DDBA5C@uow.edu.au>
	<20010520184411.K18119@athlon.random>
	<3B07F6B8.4EAB0142@uow.edu.au>
	<20010520191206.A30738@athlon.random>
	<15112.27206.4123.40450@pizda.ninka.net>
	<20010522151143.A9541@bug.ucw.cz>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Pavel Machek writes:
 > What stops you from plugging PCI-to-PCI bridges in order to create
 > some large number of slots, like 128?

Desire for decent bandwidth usage on that PCI segment perhaps ;-)

Later,
David S. Miller
davem@redhat.com
