Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267612AbTAQRVG>; Fri, 17 Jan 2003 12:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267613AbTAQRVG>; Fri, 17 Jan 2003 12:21:06 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:59812 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267612AbTAQRVF>;
	Fri, 17 Jan 2003 12:21:05 -0500
Date: Fri, 17 Jan 2003 17:27:19 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, Florian Lohoff <flo@rfc822.org>,
       netdev@oss.sgi.com
Subject: Re: eepro100 - 802.1q - mtu size
Message-ID: <20030117172719.GA31343@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
	Florian Lohoff <flo@rfc822.org>, netdev@oss.sgi.com
References: <20030117145357.GA1139@paradigm.rfc822.org> <20030117160840.GR12676@stingr.net> <20030117162818.GA1074@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030117162818.GA1074@gtf.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2003 at 11:28:18AM -0500, Jeff Garzik wrote:

 > The reason why the patch was not accepted is that it changes one magic
 > number to another magic number, and without chipset docs, I had no idea
 > what either magic number really meant.

Whilst on the subject of magic numbers in net drivers, did we ever get
to the bottom of 2.4's ChangeSet 1.587.9.20 

ftp://ftp.kernel.org/pub/linux/kernel/people/davej/patches/2.5/2.5.48/split-dj1/net-cs89x0-media-corrections.diff

?

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
