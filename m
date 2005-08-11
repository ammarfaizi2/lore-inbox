Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932277AbVHKGRr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbVHKGRr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 02:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932279AbVHKGRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 02:17:47 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:36835 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932277AbVHKGRq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 02:17:46 -0400
Date: Thu, 11 Aug 2005 08:17:28 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Christoph Hellwig <hch@infradead.org>
cc: Petr Vandrovec <vandrove@vc.cvut.cz>,
       Grzegorz Piotr Jaskiewicz <gj@kde.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: oops in VMWARE vmnet, on 2.6.12.x
In-Reply-To: <20050809164526.GA21622@infradead.org>
Message-ID: <Pine.LNX.4.61.0508110815410.28320@yvahk01.tjqt.qr>
References: <200508091744.33523@gj-laptop> <42F8D23D.3000505@vc.cvut.cz>
 <20050809164526.GA21622@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Nothing in the tarball mentiones any opensource license.  If vmware is
>actually using an opensource license please tell them to mention that
>license and remove the propritary code markers.

It's not opensource, but "proprietary and S_IRUGO". Though, the world won't 
fall down instantly if you change something [e.g. bugfix] and redistribute 
(with all the copyright stuff intact, and for non-profit)
