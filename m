Return-Path: <linux-kernel-owner+w=401wt.eu-S1161096AbXAEOZu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161096AbXAEOZu (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 09:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161101AbXAEOZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 09:25:49 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:61386 "EHLO
	pd3mo3so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161096AbXAEOZt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 09:25:49 -0500
Date: Fri, 05 Jan 2007 08:25:44 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Linux Redhat 9.0 - SATA HDD compatibility
In-reply-to: <1167988994.999206.298700@s80g2000cwa.googlegroups.com>
To: indyszeto <indyszeto@yahoo.com.hk>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <459E5FE8.3080208@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=Big5
Content-transfer-encoding: 7bit
References: <1167988994.999206.298700@s80g2000cwa.googlegroups.com>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

indyszeto wrote:
> Hi,
> 
> I had one set of RH9 installation disk made around 1-2 years ago. I've
> just bought one new WD 320GB SATA II HDD (320KS) and intend to install
> RH9 there. I used my existing PC (P4 CPU, Gigabyte motherboard),
> unplugged all existing HDD (w/ Windows XP installed) power so that the
> new SATA II HDD was the only HDD connected. I powered on PC after
> physical installation, everything seemed ran alright (BIOS could detect
> CPU, RAM, DVD drive, HDD, etc). RH9 installation program ran as
> expected but terminated at 'Disk Partition Setup', error was 'No drives
> found'.
> 
> I haven't done any partition or formatting work to this new SATA II HDD
> since I bought it. Why RH9 couldn't detect the drive while BIOS could ?
> Do I need to use more updated version of Redhat Linux to enable
> installation on this SATA II HDD ?

Red Hat 9 had very little support for SATA controllers, it's way out of
date now. You need a newer Linux distribution.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

