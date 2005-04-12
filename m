Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262453AbVDLQRt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262453AbVDLQRt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 12:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262447AbVDLQRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 12:17:46 -0400
Received: from mail.kroah.org ([69.55.234.183]:15745 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262411AbVDLQQd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 12:16:33 -0400
Date: Tue, 12 Apr 2005 09:16:02 -0700
From: Greg KH <greg@kroah.com>
To: "Kilau, Scott" <Scott_Kilau@digi.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Ihalainen Nickolay <ihanic@dev.ehouse.ru>, admin@list.net.ru,
       linux-kernel@vger.kernel.org, Wen Xiong <wendyx@us.ibm.com>
Subject: Re: Digi Neo 8: linux-2.6.12_r2  jsm driver
Message-ID: <20050412161602.GA14412@kroah.com>
References: <335DD0B75189FB428E5C32680089FB9F122152@mtk-sms-mail01.digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <335DD0B75189FB428E5C32680089FB9F122152@mtk-sms-mail01.digi.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2005 at 10:30:19AM -0500, Kilau, Scott wrote:
> However, I am NOT willing to strip out many of the features our
> customers, (and as such, your USERS) want, which is what happened with
> the JSM driver.

What features?  Didn't we end up with a valid resolution to all of the
additional stuff in the jsm driver that you originally asked for?  Why
not work on adding those new features to the serial core, and then there
would be no issue with accepting your other driver?

thanks,

greg k-h
