Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262732AbUBZISX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 03:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262735AbUBZISW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 03:18:22 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41959 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262732AbUBZIRE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 03:17:04 -0500
Message-ID: <403DAB74.1000504@pobox.com>
Date: Thu, 26 Feb 2004 03:16:52 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: kernel-ml@petermair.at
CC: linux-kernel@vger.kernel.org
Subject: Re: Adaptec 1210SA SATA Controller Performance
References: <403B5B47.2030907@petermair.at>
In-Reply-To: <403B5B47.2030907@petermair.at>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Petermair wrote:
> Hi!
> 
> Yesterday I've setup a server with Adaptec's 1210SA SATA Controller and 
> 2 SATA disks. According to the kernel changelog the controller is 
> supported since 2.6.2
> 
> I've installed Debian on an IDE disk, built a 2.6.3 kernel with 
> CONFIG_SCSI_SATA_SIL, rebooted and the kernel detected the controller 
> plus both SATA disks (sda, sdb). As the next step I wanted to create a 
> software raid 1 with the 2 SATA disks. Because it took mdadm forever to 
> finish, I checked /proc/mdstat and saw a progress bar with a rate of 
> 12MB/s!


Do you have Seagate disks?

	Jeff



