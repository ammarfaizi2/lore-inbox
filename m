Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263193AbUCTBGU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 20:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263194AbUCTBGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 20:06:20 -0500
Received: from mail.kroah.org ([65.200.24.183]:35460 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263193AbUCTBGT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 20:06:19 -0500
Date: Fri, 19 Mar 2004 17:05:54 -0800
From: Greg KH <greg@kroah.com>
To: Hanna Linder <hannal@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, davem@redhat.com, hennus@cybercomm.nl
Subject: Re: [PATCH 2.6 RFT] QIC-02 tape drive hookup to classes in sysfs
Message-ID: <20040320010554.GA18888@kroah.com>
References: <16020000.1079572101@w-hlinder.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16020000.1079572101@w-hlinder.beaverton.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2004 at 05:08:21PM -0800, Hanna Linder wrote:
> 
> Here is a patch to hook up the qic02 tape device to have class
> support in sysfs. I have verified it compiles. I do not have access to
> the hardware to test. Could someone who does please verify?
> 
> >From the file:
> * This is a driver for the Wangtek 5150 tape drive with
>  * a QIC-02 controller for ISA-PC type computers.
>  * Hopefully it will work with other QIC-02 tape drives as well.
> 
> Please consider for Testing or Inclusion

Applied, thanks.

greg k-h
