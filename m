Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932447AbWFJRDV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932447AbWFJRDV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 13:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932505AbWFJRDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 13:03:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6569 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932447AbWFJRDU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 13:03:20 -0400
Date: Sat, 10 Jun 2006 10:03:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: michal.k.k.piotrowski@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc6-mm2
Message-Id: <20060610100318.8900f849.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606100951340.7174@schroedinger.engr.sgi.com>
References: <20060609214024.2f7dd72c.akpm@osdl.org>
	<6bffcb0e0606100323p122e9b23g37350fa9692337ae@mail.gmail.com>
	<20060610092412.66dd109f.akpm@osdl.org>
	<Pine.LNX.4.64.0606100939480.6651@schroedinger.engr.sgi.com>
	<Pine.LNX.4.64.0606100951340.7174@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I've placed a rollup of 2.6.17-rc6-mm2 minus the zoned-vm and eventcounter
patches at

	http://www.zip.com.au/~akpm/linux/patches/stuff/cl.bz2

Patches against that would suit.

I won't be in a position to do much merging or any testing for the next
week, so no rush.

