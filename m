Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263582AbUEGOwh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263582AbUEGOwh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 10:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263585AbUEGOwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 10:52:37 -0400
Received: from wsip-68-14-253-125.ph.ph.cox.net ([68.14.253.125]:32461 "EHLO
	office.labsysgrp.com") by vger.kernel.org with ESMTP
	id S263582AbUEGOwf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 10:52:35 -0400
Message-ID: <409BA2B2.8050508@backtobasicsmgmt.com>
Date: Fri, 07 May 2004 07:52:34 -0700
From: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Organization: Back To Basics Network Management
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: ACPI Developers <acpi-devel@lists.sourceforge.net>
Subject: Re: [ACPI] [PATCH] can we compile ACPI without define CONFIG_PM ?
References: <A6974D8E5F98D511BB910002A50A6647615F9FD0@hdsmsx403.hd.intel.com>	 <1083903538.2296.248.camel@dhcppc4> <1083929581.9706.35.camel@darkstar>
In-Reply-To: <1083929581.9706.35.camel@darkstar>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sérgio Monteiro Basto wrote:

> 1 - ACPI w/o CONFIG_PM (is not supported)
> 
> 2 - If accidentally we configure ACPI w/o CONFIG_PM. I tested and
> doesn't power off correctly (at least on one Dell Precision 410). 

It works on my two server boxes here; ACPI turned on (button, fan, 
processor, thermal zone and timer options only), but power management 
not turned on. Both machines properly power off when asked.
