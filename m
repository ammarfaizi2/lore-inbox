Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316039AbSENU3R>; Tue, 14 May 2002 16:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316040AbSENU3Q>; Tue, 14 May 2002 16:29:16 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:50879 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S316039AbSENU3P>;
	Tue, 14 May 2002 16:29:15 -0400
Date: Tue, 14 May 2002 22:29:12 +0200
From: bert hubert <ahu@ds9a.nl>
To: Andre LeBlanc <ap.leblanc@shaw.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: No Network after Compiling, 2.4.19-pre8 under Debian Woody
Message-ID: <20020514202912.GA18544@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Andre LeBlanc <ap.leblanc@shaw.ca>, linux-kernel@vger.kernel.org
In-Reply-To: <003c01c1fb9d$345e0a20$2000a8c0@metalbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2002 at 04:15:14PM -0700, Andre LeBlanc wrote:
> Ok, the system is a Duron 1GHz on an ECS Motherboard with the SiS 730S
> Chipset. 384 MB PC133, with a realtek 8139 based Nic.
> heres the .config
> 
> network works fine if I boot the old(2.2.20) kernel but booting 2.4.19-pre8
> causes me to have no network connection, But the device is configured
> properly. (I Think)
> I can also send my dmesg if it will help

Please do. Also show the output of ifconfig before and after trying to ping
some hosts.

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://www.tk                              the dot in .tk
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
