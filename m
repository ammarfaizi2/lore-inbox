Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261283AbVAGHYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261283AbVAGHYJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 02:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbVAGHYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 02:24:08 -0500
Received: from mail.kroah.org ([69.55.234.183]:55940 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261296AbVAGHYB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 02:24:01 -0500
Date: Thu, 6 Jan 2005 23:23:16 -0800
From: Greg KH <greg@kroah.com>
To: "Bhupesh Kumar Pandey, Noida" <bhupeshp@noida.hcltech.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Help regarding PCI Express hot Plug functionality in kernel 2 .6.8
Message-ID: <20050107072316.GA24620@kroah.com>
References: <267988DEACEC5A4D86D5FCD780313FBB0342D4A8@exch-03.noida.hcltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <267988DEACEC5A4D86D5FCD780313FBB0342D4A8@exch-03.noida.hcltech.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2005 at 12:44:05PM +0530, Bhupesh Kumar Pandey, Noida wrote:
>  
> Hi all,
> Please help me in investigating linux kernel 2.6.8 fot its hotplugging
> support on PCI Express bus.
> Is it support this and I not the what are the limitations and problems.

Yes it supports it.  It should work just fine.  If not, please let us
know any problems you have.

thanks,

greg k-h
