Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261358AbULNAmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbULNAmO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 19:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261359AbULNAmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 19:42:14 -0500
Received: from main.gmane.org ([80.91.229.2]:16780 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261358AbULNAmG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 19:42:06 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kevin Puetz <puetzk@puetzk.org>
Subject: Re: [WISHLIST] IBM HD Shock detection in Linux
Date: Mon, 13 Dec 2004 18:41:53 -0600
Message-ID: <cplcsi$2rj$1@sea.gmane.org>
References: <1102888882.15558.2.camel@ksyrium.local> <Pine.LNX.4.61.0412122305010.29854@yvahk01.tjqt.qr> <1102889485.15558.5.camel@ksyrium.local> <Pine.LNX.4.61.0412122314560.10353@yvahk01.tjqt.qr> <Pine.LNX.4.61.0412122345440.3369@dragon.hygekrogen.localhost> <Pine.LNX.4.61.0412122340320.31793@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 12-219-2-179.client.mchsi.com
User-Agent: KNode/0.8.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:

>>that it stops the harddrive. How effective that is I don't know - I have
>>no further knowledge or experience with this.
> 
> stop is a good operation, but I doubt the heads won't scratch the cyls
> when the disk is falling from a desk's height.
 
It's not going to get the platter spun down, but it might survive if it
managed to get the head off the platter and into the cradle. If we figure
it's got a 20ms seek time (laptop drive, should be ~right) it should be
able to get the heads off to the side within about 4cm... clever :-)

> Jan Engelhardt


