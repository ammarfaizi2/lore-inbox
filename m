Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262121AbVAJGwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262121AbVAJGwW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 01:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262122AbVAJGwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 01:52:22 -0500
Received: from ngate.noida.hcltech.com ([202.54.110.230]:62939 "EHLO
	ngate.noida.hcltech.com") by vger.kernel.org with ESMTP
	id S262121AbVAJGwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 01:52:18 -0500
Message-ID: <267988DEACEC5A4D86D5FCD780313FBB03500BDC@exch-03.noida.hcltech.com>
From: "Bhupesh Kumar Pandey, Noida" <bhupeshp@noida.hcltech.com>
To: linux-kernel@vger.kernel.org
Cc: Greg KH <greg@kroah.com>
Subject: RE: regarding hotpluggable devices adn linux kernel
Date: Mon, 10 Jan 2005 12:19:21 +0530
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Actually I want to know the how hotplugging works under 2.6 and what is the
information flow and how a user can do this.
Secondly is it support PnP of iSCSI disks? If yes then it has support in
kernel or any patch is nedded? If no then what are the problems.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Thanks and Best Regards
Bhupesh Kumar Pandey


-----Original Message-----
From: Greg KH [mailto:greg@kroah.com] 
Sent: Monday, January 10, 2005 12:09 PM
To: Bhupesh Kumar Pandey, Noida
Cc: linux-kernel@vger.kernel.org
Subject: Re: regarding hotpluggable devices adn linux kernel

On Mon, Jan 10, 2005 at 11:06:45AM +0530, Bhupesh Kumar Pandey, Noida wrote:
> Hello,
> Recently I came across a good document "Hotpluggable devices and the 
> linux kernel" by you (Greg Kroah-Hartman).
> This document is based on linux kernel 2.4 series. Is there any same 
> document which descibe the working of kernel 2.6 series.

It works the same, only better :)

Specifically what are you curious about?  Have you read the
linux-hotplug.sf.net documentation?

thanks,

greg k-h
