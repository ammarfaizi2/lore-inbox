Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751213AbVKEE70@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbVKEE70 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 23:59:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbVKEE70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 23:59:26 -0500
Received: from mail.kroah.org ([69.55.234.183]:22715 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751211AbVKEE7Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 23:59:25 -0500
Date: Fri, 4 Nov 2005 20:30:56 -0800
From: Greg KH <greg@kroah.com>
To: Frank Overton <frank@discoverycenters.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 series kernels panic on boot at PCI probe with 450nx
Message-ID: <20051105043056.GA25501@kroah.com>
References: <436BF7BB.9070900@discoverycenters.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <436BF7BB.9070900@discoverycenters.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2005 at 04:07:23PM -0800, Frank Overton wrote:
> [1.] 2.6 series kernels panic on boot at PCI probe with 450nx (2.4.x 
> kernels boot without hitch)  [2.] System: HP Netserver LH4s

Can you post the oops message that you see?

thanks,

greg k-h
