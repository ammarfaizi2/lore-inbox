Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274881AbTGaWdL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 18:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274886AbTGaWdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 18:33:11 -0400
Received: from mail.kroah.org ([65.200.24.183]:46252 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S274881AbTGaWdJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 18:33:09 -0400
Date: Thu, 31 Jul 2003 15:32:04 -0700
From: Greg KH <greg@kroah.com>
To: "Frederick, Fabian" <Fabian.Frederick@prov-liege.be>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Linux-Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH repost] SHM to Sysfs
Message-ID: <20030731223204.GA5302@kroah.com>
References: <D9B4591FDBACD411B01E00508BB33C1B01BF8C47@mesadm.epl.prov-liege.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D9B4591FDBACD411B01E00508BB33C1B01BF8C47@mesadm.epl.prov-liege.be>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 30, 2003 at 09:27:15AM +0200, Frederick, Fabian wrote:
> Alan,
> 
> The patch at the link below applies against 2.6.0.test2 and displays shm in
> sysfs.
> 
> http://fabian.unixtech.be/kernel/ipctosysfs.html
> 
> Could you apply ?

Can you post it to this list to verify that you have the .release stuff
correct this time?

thanks,

greg k-h
