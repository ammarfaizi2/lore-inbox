Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261939AbVDVLNX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbVDVLNX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 07:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261983AbVDVLNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 07:13:22 -0400
Received: from animx.eu.org ([216.98.75.249]:20966 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S261939AbVDVLNU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 07:13:20 -0400
Date: Fri, 22 Apr 2005 07:14:05 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: "Tais M. Hansen" <tais.hansen@osd.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SATA/ATAPI
Message-ID: <20050422111404.GA13381@animx.eu.org>
Mail-Followup-To: "Tais M. Hansen" <tais.hansen@osd.dk>,
	linux-kernel@vger.kernel.org
References: <200504211941.43889.tais.hansen@osd.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504211941.43889.tais.hansen@osd.dk>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tais M. Hansen wrote:
> I know there has been some talking about SATA/ATAPI being experimental and 
> might not work at all under kernel-2.6.x.
> 
> One of my linux boxes has a Plextor DVD-RW drive with a SATA interface. The 
> kernel sees this drive (ata3) but apparently doesn't tie it to a sdx device. 
> The box also have a SATA harddisk, which is working just fine. The relevant 
> dmesg output is pasted below.
> 
> Is there anything I can do to help the development of SATA/ATAPI devices?

I thought all SCSI cdroms were using /dev/scdx or /dev/srx.  Atleast all
mine are (I use ide-scsi for ide disks)

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
