Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934961AbWK3E1z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934961AbWK3E1z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 23:27:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935691AbWK3E1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 23:27:52 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:17354
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S935086AbWK3E1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 23:27:34 -0500
Date: Wed, 29 Nov 2006 20:27:33 -0800 (PST)
Message-Id: <20061129.202733.36664231.davem@davemloft.net>
To: chrisw@sous-sol.org
Cc: clem@clem.clem-digital.net, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19 panic on boot -- i386
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061130042759.GL1397@sequoia.sous-sol.org>
References: <200611300313.kAU3D9J7007005@clem.clem-digital.net>
	<20061129.201220.88477321.davem@davemloft.net>
	<20061130042759.GL1397@sequoia.sous-sol.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Wright <chrisw@sous-sol.org>
Date: Wed, 29 Nov 2006 20:27:59 -0800

> * David Miller (davem@davemloft.net) wrote:
> > From: Pete Clements <clem@clem.clem-digital.net>
> > Date: Wed, 29 Nov 2006 22:13:09 -0500 (EST)
> > 
> > > 2.6.19 panics at boot. Good up through rc6-git11.
> > > Hand copied screen below.
> > 
> > Here is the fix, which was posted in response to a seperate
> > report of this problem here:
> 
> looks like 2.6.19.1 material ;-)

Check stable@kernel.org's inbox, I just sent it in :)
