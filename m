Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbUGXPx2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbUGXPx2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 11:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbUGXPx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 11:53:28 -0400
Received: from kendyke.static.mt.net ([206.127.66.26]:60544 "EHLO
	hooke.localhost.localdomain") by vger.kernel.org with ESMTP
	id S261426AbUGXPx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 11:53:27 -0400
Date: Sat, 24 Jul 2004 09:53:26 -0600
From: gadgeteer@elegantinnovations.org
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Delete cryptoloop
Message-ID: <20040724155326.GV4109@hyper>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0407211609230.19655@devserv.devel.redhat.com> <20040721230044.20fdc5ec.akpm@osdl.org> <4411.24.6.231.172.1090470409.squirrel@24.6.231.172> <20040722014649.309bc26f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040722014649.309bc26f.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, I want to hear from "someone else".  If removing cryptoloop will
> irritate five people, well, sorry.  If it's 5,000 people, well maybe not.

I'm not 5000 just one over-worked sysadmin.  We are using cryptoloop on
a handful of very key servers that 300+ remote offices transmit critical
data through.  I was aware of the weaknesses when I implemented but it
was the best available at the time.

Happy to migrate to dm-crypt when the userland tools are ready.
-- 
Chief Gadgeteer
Elegant Innovations
