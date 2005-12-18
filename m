Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965284AbVLRWTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965284AbVLRWTL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 17:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965293AbVLRWTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 17:19:11 -0500
Received: from gate.crashing.org ([63.228.1.57]:48349 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S965284AbVLRWTK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 17:19:10 -0500
Subject: Re: USB rejecting sleep
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       David Brownell <david-b@pacbell.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20051218215051.GA18257@kroah.com>
References: <1134937642.6102.85.camel@gaston>
	 <20051218215051.GA18257@kroah.com>
Content-Type: text/plain
Date: Mon, 19 Dec 2005 09:13:50 +1100
Message-Id: <1134944031.6102.103.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-12-18 at 13:50 -0800, Greg KH wrote:

> Yes it is, and I have a patch in my tree now that fixes this up and
> keeps the suspend process working properly for usb drivers that do not
> have a suspend function.
> 
> Hm, I wonder if it should go in for 2.6.15?

Do you have an URL I can send to those users to test ?

Thanks !
Ben.


