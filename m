Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265578AbSJXRqz>; Thu, 24 Oct 2002 13:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265580AbSJXRqz>; Thu, 24 Oct 2002 13:46:55 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14342 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S265578AbSJXRqx>;
	Thu, 24 Oct 2002 13:46:53 -0400
Message-ID: <3DB83378.5090603@pobox.com>
Date: Thu, 24 Oct 2002 13:52:56 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "KOCHI, Takayoshi" <t-kouchi@mvf.biglobe.ne.jp>
CC: jung-ik.lee@intel.com, greg@kroah.com, tony.luck@intel.com,
       pcihpd-discuss@lists.sourceforge.net, linux-ia64@linuxia64.org,
       linux-kernel@vger.kernel.org
Subject: Re: PCI Hotplug Drivers for 2.5
References: <72B3FD82E303D611BD0100508BB29735046DFF41@orsmsx102.jf.intel.com> <20021025023856.CAVTC0A82650.6C9EC293@mvf.biglobe.ne.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

KOCHI, Takayoshi wrote:
>>We need this driver as it's the only solution for DIG64 compliant IPF
>>platforms.
> 
> 
> No, not for all DIG64 compliant IPF platforms.  NEC TX7 is also
> a DIG64 compliant IPF platform but doesn't need your driver.



Tangent:

Intel is wrong by renaming IA64 to "IPF".

It was previously used as "Intel Processor Family".  IA64 is a far 
better name, and I will continue to use that in preference to IPF. 
Re-using an acronym is silly and creates confusion.


	Jeff



