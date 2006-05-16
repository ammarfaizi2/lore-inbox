Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751463AbWEPFiQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463AbWEPFiQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 01:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbWEPFiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 01:38:15 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:39100 "EHLO
	pd4mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751463AbWEPFiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 01:38:15 -0400
Date: Mon, 15 May 2006 23:35:22 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: acpi_power_off doesn't
In-reply-to: <6d08v-5T4-15@gated-at.bofh.it>
To: Harald Dunkel <harald.dunkel@t-online.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <4469649A.80203@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <6cPPS-7BT-33@gated-at.bofh.it> <6d08v-5T4-15@gated-at.bofh.it>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Harald Dunkel wrote:
> Hi Len,
> 
> The problem does not exist, if I boot my PC and then
> halt it immediately. If I login and use it for some
> time, then acpi_power_off does not work.
> 
> Box 'X' is an Aopen MZ-915M, CPU is a 2 GHz Pentium
> M. It is running Debian Sid, kernel is vanilla
> 
> Linux bugs 2.6.17-rc4 #1 PREEMPT Sat May 13 16:22:54 CEST 2006 i686 GNU/Linux
> 
> Old kernels don't work on this PC due to missing
> hardware support. The first vanilla kernel that worked
> reliably on this box (except for acpi_power_off) was 2.6.16.

Do you get any ACPI execution errors, etc. in the dmesg output after the 
system has been running for a while? I've seen this happen after the 
ACPI machinery gets into a bad state..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

