Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268757AbRG0Czt>; Thu, 26 Jul 2001 22:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268759AbRG0Czl>; Thu, 26 Jul 2001 22:55:41 -0400
Received: from imo-d09.mx.aol.com ([205.188.157.41]:30674 "EHLO
	imo-d09.mx.aol.com") by vger.kernel.org with ESMTP
	id <S268757AbRG0Czf>; Thu, 26 Jul 2001 22:55:35 -0400
Date: Thu, 26 Jul 2001 22:55:39 -0400
From: hochakhung@netscape.net
To: linux-kernel@vger.kernel.org
Subject: Lock the page
Message-ID: <03E90795.17A1F592.0F45C3B8@netscape.net>
X-Mailer: Atlas Mailer 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

After getting a page from alloc_pages(mask, order), is it necessary to lock the page to prevent it from being swapped out? Can I assume that I already have exclusive access to the page? Can I assume that the page is free and no other kernel control paths would use it?

Any help would be greatly appreciated

Thanks


__________________________________________________________________
Your favorite stores, helpful shopping tools and great gift ideas. Experience the convenience of buying online with Shop@Netscape! http://shopnow.netscape.com/

Get your own FREE, personal Netscape Mail account today at http://webmail.netscape.com/

