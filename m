Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266663AbUH0RBz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266663AbUH0RBz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 13:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266670AbUH0RBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 13:01:55 -0400
Received: from mail.kroah.org ([69.55.234.183]:3023 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266657AbUH0RBn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 13:01:43 -0400
Date: Fri, 27 Aug 2004 10:01:08 -0700
From: Greg KH <greg@kroah.com>
To: Kenneth Lavrsen <kenneth@lavrsen.dk>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: kernel 2.6.8 pwc patches and counterpatches
Message-ID: <20040827170108.GJ32244@kroah.com>
References: <6.1.2.0.2.20040827171755.01c1f328@inet.uni2.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6.1.2.0.2.20040827171755.01c1f328@inet.uni2.dk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2004 at 06:26:14PM +0200, Kenneth Lavrsen wrote:
> 
> When Greg decided to remove the hook that enabled the use of pwcx HE 
> decided to remove the driver.

Not true, see my summary of the issues in another post on this list.

You relied on a binary, closed source driver, and so you relied on the
whims of the owner of such a driver.  It's a tough lesson to learn, I
realize, sorry :(

greg k-h
