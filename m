Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270808AbTHFQuf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 12:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270819AbTHFQuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 12:50:35 -0400
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:42251 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S270808AbTHFQub
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 12:50:31 -0400
Message-ID: <3F3131D2.7050009@rackable.com>
Date: Wed, 06 Aug 2003 09:50:26 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Brown, Len" <len.brown@intel.com>
CC: "Feldman, Scott" <scott.feldman@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: More 2.4.22pre10 ACPI breakage
References: <BF1FE1855350A0479097B3A0D2A80EE009FC0C@hdsmsx402.hd.intel.com>
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE009FC0C@hdsmsx402.hd.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Aug 2003 16:50:29.0101 (UTC) FILETIME=[D791A1D0:01C35C3A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brown, Len wrote:

>If it still fails with the latest BIOS (11.0)
>http://support.intel.com/support/motherboards/server/se7501br2/
>  
>

   I will need to check on that.

>Please be encouraged to file a bug at bugzilla.kernel.org
>Component: ACPI
>Owner: linux-acpi@unix-os.sc.intel.com
>If you can drop in the good/bad dmesg, lspci, and /proc/interrupts,
>That would be great.
>
>Thanks,
>-Len
>
>Ps. If it is an ACPI interrupt config problem, it should boot also with
>pci=noacpi
>
>  
>
  It boots fine with acpi=no.  I did not try pci=noacpi

