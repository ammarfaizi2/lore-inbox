Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263984AbUFFSur@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263984AbUFFSur (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 14:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264012AbUFFSur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 14:50:47 -0400
Received: from smtp-out2.blueyonder.co.uk ([195.188.213.5]:18807 "EHLO
	smtp-out2.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S263984AbUFFSug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 14:50:36 -0400
Message-ID: <40C36779.6040506@blueyonder.co.uk>
Date: Sun, 06 Jun 2004 19:50:33 +0100
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Len Brown <len.brown@intel.com>
CC: linux-kernel@vger.kernel.org, Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: 2.6.7-rc2-mm1 (nforce2 lockup)
References: <A6974D8E5F98D511BB910002A50A6647615FD33E@hdsmsx403.hd.intel.com>	 <1086385540.2241.322.camel@dhcppc4>  <40C1455E.30501@blueyonder.co.uk> <1086410810.2288.339.camel@dhcppc4>
In-Reply-To: <1086410810.2288.339.camel@dhcppc4>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Jun 2004 18:50:37.0863 (UTC) FILETIME=[28512B70:01C44BF7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Len Brown wrote:

>On Sat, 2004-06-05 at 00:00, Sid Boyce wrote:
>
>  
>
>>I just built and successfully booted 2.6.7-rc2-mm2 IOAPIC enabled and 
>>without boot option acpi=off. I guess somewhere IOAPIC was inadvertently 
>>disabled in .config.
>>    
>>
>
>Hmmm, so you should be able to make this new kernel boot-hang with
>"noapic", yes?
>  
>
pci=noapic gives the original freeze.

>How about if you go all the way and use "nolapic"?
>  
>
hda: max request size 128KiB
hda: lost interrupt
hda: lost interrupt

Regards
Sid.

-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
Linux Only Shop.

