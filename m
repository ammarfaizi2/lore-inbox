Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133075AbRDLIpz>; Thu, 12 Apr 2001 04:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133076AbRDLIph>; Thu, 12 Apr 2001 04:45:37 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:11023 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S133074AbRDLIpV>;
	Thu, 12 Apr 2001 04:45:21 -0400
Date: Thu, 12 Apr 2001 10:45:13 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: watermodem <aquamodem@ameritech.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: No 100 HZ timer !
Message-ID: <20010412104513.D25536@pcep-jamie.cern.ch>
In-Reply-To: <E14n0J3-0004U6-00@the-village.bc.nu> <3AD53C66.92B8D6BE@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AD53C66.92B8D6BE@ameritech.net>; from aquamodem@ameritech.net on Thu, Apr 12, 2001 at 12:25:58AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

watermodem wrote:
> As somebody who is now debating how to measure latencies in a 
> giga-bit ethernet environment with several components doing 
> L3 switching in much less than 10 micro-seconds ... (hardware)
> I agree that some method is need to achieve higher resolutions.  
> (Sigh... I will likely need to buy something big and expensive)
> {this is for a system to make use of L. Yarrow's little protocol}

Use Alteon/Netgear cards, everyone else seems to be :-)  We get
measurements on the order of 100ns, if we are just measuring network
latencies.  (Data is not transferred over the PCI bus).

-- Jamie
