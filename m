Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268115AbUHFImx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268115AbUHFImx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 04:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268110AbUHFImX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 04:42:23 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:32935 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S268106AbUHFIjq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 04:39:46 -0400
Date: Fri, 6 Aug 2004 10:39:44 +0200
From: bert hubert <ahu@ds9a.nl>
To: Mike <turbanator1@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB2 DVD+R/RW Writer issues
Message-ID: <20040806083944.GA27990@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Mike <turbanator1@verizon.net>, linux-kernel@vger.kernel.org
References: <004101c47b73$4280a880$0300a8c0@r000000>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <004101c47b73$4280a880$0300a8c0@r000000>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2004 at 01:07:23AM -0400, Mike wrote:
> I have an external USB 2.0/Firewire HP DVD200E DVD+R/RW drive, connected to
> my system through an after-market USB 2.0 card. My USB 2.0 card has a VIA
> VT6212 chipset. I cannot use this drive when it is connected to the card.
> DVDs will not read or write and CDs will not read or write. Attempting to
> mount a DVD or a CD results in various errors being spit out. I have EHCI

Please list those errors, please tell us how you try to mount the disk,
please confirm that the drive IS working on other systems, please tell us
which version of the kernel you are using. A configuration very much like
the above works fine for me.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
