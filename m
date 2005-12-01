Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932395AbVLASYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbVLASYn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 13:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932397AbVLASYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 13:24:43 -0500
Received: from mail.kroah.org ([69.55.234.183]:40115 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932395AbVLASYm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 13:24:42 -0500
Date: Thu, 1 Dec 2005 10:22:57 -0800
From: Greg KH <greg@kroah.com>
To: Vitaly Wool <vwool@ru.mvista.com>
Cc: linux-kernel@vger.kernel.org, david-b@pacbell.net, dpervushin@gmail.com,
       akpm@osdl.org, basicmark@yahoo.com, komal_shah802003@yahoo.com,
       stephen@streetfiresound.com, spi-devel-general@lists.sourceforge.net,
       Joachim_Jaeger@digi.com
Subject: Re: [PATCH 2.6-git] SPI core refresh
Message-ID: <20051201182257.GB20516@kroah.com>
References: <20051201191109.40f2d04b.vwool@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051201191109.40f2d04b.vwool@ru.mvista.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2005 at 07:11:09PM +0300, Vitaly Wool wrote:
> - Matching Greg K-H's requests expressed in his review

No, you got the kernel doc wrong, and you didn't move your inline
functions.

> - The character device interface was reworked

reworked how?

> - it's more adapted for use in real-time environments

I still do not see why you are stating this.  Why do you say this?

I think you should work with David more...

thanks,

greg k-h
