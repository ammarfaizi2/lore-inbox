Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265266AbTGCTDb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 15:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265269AbTGCTDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 15:03:31 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:28061 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S265266AbTGCTDa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 15:03:30 -0400
Date: Thu, 3 Jul 2003 12:17:55 -0700
From: Greg KH <greg@kroah.com>
To: Jan Dittmer <j.dittmer@portrix.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i2c convert via686a temp_* to milli degree celsius
Message-ID: <20030703191755.GA2456@kroah.com>
References: <3EF94E57.9070802@portrix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EF94E57.9070802@portrix.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 25, 2003 at 09:25:11AM +0200, Jan Dittmer wrote:
> Forgot to send this.
> 
> This converts the i2c chip driver via686a to handle milli degree celsius 
> instead of centi degree celsius. Applies for temp_input, temp_min, temp_max.

Sorry for the delay, I've now applied this and will send it on.

thanks,

greg k-h
