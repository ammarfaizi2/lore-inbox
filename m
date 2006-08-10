Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932150AbWHJU4G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbWHJU4G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbWHJU4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:56:06 -0400
Received: from mx1.redhat.com ([66.187.233.31]:23239 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932150AbWHJU4D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 16:56:03 -0400
Message-ID: <44DB9D29.7090504@redhat.com>
Date: Thu, 10 Aug 2006 16:55:05 -0400
From: Prarit Bhargava <prarit@redhat.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Len Brown <lenb@kernel.org>
CC: Yasunori Goto <y-goto@jp.fujitsu.com>, akpm@osdl.org,
       keith mannthey <kmannth@us.ibm.com>,
       ACPI-ML <linux-acpi@vger.kernel.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>
Subject: Re: [PATCH](memory hotplug) Repost remove useless message at boot
 time from 2.6.18-rc4.
References: <20060804213230.D5D4.Y-GOTO@jp.fujitsu.com> <20060810142329.EB03.Y-GOTO@jp.fujitsu.com> <44DB965A.3050208@redhat.com> <200608101654.58358.len.brown@intel.com>
In-Reply-To: <200608101654.58358.len.brown@intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> [20060707] is the version (yes, it is a date) of the ACPICA core.
> The ACPI_EXCEPTION() macro appends it to the exception message.
>
>   
I just figured that out :) ... Seems okay to me.

P.
> -Len
>   
