Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267195AbUHOWgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267195AbUHOWgN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 18:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267197AbUHOWgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 18:36:13 -0400
Received: from gate.crashing.org ([63.228.1.57]:48532 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S267195AbUHOWgJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 18:36:09 -0400
Subject: Re: [PATCH][2.6] Move Sungem to gige menu
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20040815162129.A2700@infradead.org>
References: <Pine.LNX.4.58.0408141412550.22077@montezuma.fsmlabs.com>
	 <20040815104900.A805@infradead.org>
	 <Pine.LNX.4.58.0408151103490.22078@montezuma.fsmlabs.com>
	 <Pine.LNX.4.58.0408151116520.22078@montezuma.fsmlabs.com>
	 <20040815162129.A2700@infradead.org>
Content-Type: text/plain
Message-Id: <1092608813.9536.21.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 16 Aug 2004 08:26:53 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-16 at 01:21, Christoph Hellwig wrote:
> On Sun, Aug 15, 2004 at 11:17:25AM -0400, Zwane Mwaikambo wrote:
> > The confusion came about when i was searching for the GigE NIC driver for
> > the G5
> 
> I think that can only mean we should get rid of that confusing menu ASAP.

Heh, agreed.

In the case of sungem, it depends on the PHY connected to it, it's
gigabit on desktops & high end laptops, and 10/100 on ibooks and most
imacs. I suppose the ones used by Sun are all gigabit tho.

Ben.


