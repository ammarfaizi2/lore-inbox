Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261854AbVF1QuT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261854AbVF1QuT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 12:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261817AbVF1QuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 12:50:18 -0400
Received: from mail.kroah.org ([69.55.234.183]:8885 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261854AbVF1Qtt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 12:49:49 -0400
Date: Tue, 28 Jun 2005 09:49:16 -0700
From: Greg KH <greg@kroah.com>
To: Vitaly Wool <vwool@dev.rtsoft.ru>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] SPI core -- revisited
Message-ID: <20050628164916.GA10811@kroah.com>
References: <20050626193621.8B8E44C4D1@abc.pervushin.pp.ru> <200506270049.10970.adobriyan@gmail.com> <1119819580.3215.47.camel@laptopd505.fenrus.org> <42BF7496.7080204@dev.rtsoft.ru> <1119860886.3186.30.camel@laptopd505.fenrus.org> <42BFC348.5040709@dev.rtsoft.ru> <20050627102047.B10822@flint.arm.linux.org.uk> <42BFD2EA.5060808@dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42BFD2EA.5060808@dev.rtsoft.ru>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2005 at 02:20:26PM +0400, Vitaly Wool wrote:
> But -- does the interfaces review imply checking wthether the figure 
> brackets are complying to K&R? ;)

Yes.  If you get the coding style wrong, it's harder for all of us to
review the code.  See my old OLS paper about coding style for the
research that backs this up.  

Basically, if the format is wrong, your brain has a much harder time to
see the actual logic of your code.  And you want us to review the logic
:)

thanks,

greg k-h
