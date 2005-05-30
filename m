Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261842AbVEaAF0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261842AbVEaAF0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 20:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261647AbVEaADl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 20:03:41 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:64369 "EHLO
	pd2mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S261729AbVE3X4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 19:56:02 -0400
Date: Mon, 30 May 2005 17:54:51 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Adaptec AIC-79xx HostRaid
In-reply-to: <49ZZT-qS-29@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <429BA7CB.1040400@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <49Zx1-8ne-21@gated-at.bofh.it> <49ZZT-qS-29@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> I would be very suspicious about the claim that the xor stuff is done in
> hardware and not in the binary part. I'm actually surprised that a linux
> friendly company like IBM actually gets involved with binary drivers
> like this though.... a bit disappointing.
> 
> but yeah this sounds like a really bad purchase.

Indeed, this controller in the 346s is a regression from the 345 
servers, which had an onboard LSI Logic Fusion MPT controller which 
could do hardware RAID 1, at least, and has a GPL driver.

Oh well.. if you really want to use hardware RAID, you can put in the 
ServeRAID-7k card, which is much better, and has a GPL driver.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

