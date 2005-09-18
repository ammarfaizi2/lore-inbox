Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932119AbVIRRMV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbVIRRMV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 13:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932120AbVIRRMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 13:12:21 -0400
Received: from twin.uoregon.edu ([128.223.214.27]:36498 "EHLO twin.uoregon.edu")
	by vger.kernel.org with ESMTP id S932119AbVIRRMV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 13:12:21 -0400
Date: Sun, 18 Sep 2005 10:12:01 -0700 (PDT)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: joelja@twin.uoregon.edu
To: Marc Perkel <marc@perkel.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Wanted - Recommendation of good motherboard for AMD Athlon 64
 X2
In-Reply-To: <432D99C4.5020000@perkel.com>
Message-ID: <Pine.LNX.4.63.0509180957480.6114@twin.uoregon.edu>
References: <432D99C4.5020000@perkel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Sep 2005, Marc Perkel wrote:

> I'm leaning towards scrappung my Ass motherboard for having a LOT of Linux 
> problems. Looking for a recommendation of what to replace it with.
>
> I want something that is highly Linux frendly and "just works".

The via k8t800 based boards has "just worked" from day 1 for me going back 
to my socket 754 athlon 64 3000+ which is now fairly old.

As a brdige chipset it's starting to show it's age since it's agp rather 
than pci-x.

> Running Athlon 64 X2 4400+
> Needs 4 SATA ports - prefer SATA II
> VGA on MB would be nice but not required.
> MUST run with 4 gigs of ram. I have Kingston HyperX which should be plenty 
> fast.

I sort of afraid of running machines with 4GB or more of ram without ecc 
memory, but that could be a personal fetish... at this level that argues 
in favor of a socket 940 rather than 939.



> I'm running Fedora Core 4 on it.
> I'm Running Maxtor drives that support NCQ even though the SATA interface is 
> 1.5gb
>
> I don't need raid.

most of the amd64 systems I build are for servers and most of those have 
tyan mainboards at this point.

I'm sort of fascinated with the asrock/uli chipset mainboards that's 
floating around but I have actually splurged yet, and I haven't had a uli 
chipset mainboard since my cyrix 5x86mx 100 died a couple years ago.

http://www.tomshardware.com/motherboard/20050916/index.html

http://www.newegg.com/Product/Product.asp?Item=N82E16813157081

> What out there actually works.
>
>

-- 
--------------------------------------------------------------------------
Joel Jaeggli  	       Unix Consulting 	       joelja@darkwing.uoregon.edu
GPG Key Fingerprint:     5C6E 0104 BAF0 40B0 5BD3 C38B F000 35AB B67F 56B2

