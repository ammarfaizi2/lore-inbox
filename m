Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267217AbTAVBZp>; Tue, 21 Jan 2003 20:25:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267243AbTAVBZp>; Tue, 21 Jan 2003 20:25:45 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:20184 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267217AbTAVBZo>;
	Tue, 21 Jan 2003 20:25:44 -0500
Date: Wed, 22 Jan 2003 01:31:30 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: "Matthew D. Pitts" <mpitts@suite224.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: NForce Chipset support in which kernels?
Message-ID: <20030122013130.GA1652@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Alan <alan@lxorguk.ukuu.org.uk>,
	"Matthew D. Pitts" <mpitts@suite224.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3E287188.9030909@hanaden.com> <1043052878.12182.26.camel@dhcp22.swansea.linux.org.uk> <001d01c2c161$90449f40$0100a8c0@pcs686> <1043189251.1384.9.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1043189251.1384.9.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2003 at 10:47:32PM +0000, Alan Cox wrote:
 > On Tue, 2003-01-21 at 15:24, Matthew D. Pitts wrote:
 > > Unless you get the drivers from nVIDIA website.
 > 
 > Which are binary only. So its still best avoided
 
For someone with far too much time on their hands, the
20KB binary object (complete with symbols) shouldn't be
too much work to reverse engineer 8)

Although Jeff seems to be think that the chip is a clone
of another existing NIC, so it may not be worth the effort
if $driver can be made to work with it by adding some IDs..

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
