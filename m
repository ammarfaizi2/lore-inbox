Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131140AbRCUDUX>; Tue, 20 Mar 2001 22:20:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131151AbRCUDUO>; Tue, 20 Mar 2001 22:20:14 -0500
Received: from glatton.cnchost.com ([207.155.248.47]:7604 "EHLO
	glatton.cnchost.com") by vger.kernel.org with ESMTP
	id <S131140AbRCUDUB>; Tue, 20 Mar 2001 22:20:01 -0500
Message-ID: <3AB81E4A.9060604@devries.tv>
Date: Tue, 20 Mar 2001 22:21:46 -0500
From: Peter DeVries <peter@devries.tv>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22 i686; en-US; 0.7) Gecko/20010105
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Drvie Corruption CONSTANTLY with Linux and KT7-RAID
In-Reply-To: <Pine.LNX.4.10.10103151153050.28602-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have noiw tried the following
   Diffrent Ram
   No PNP/ Manual set IRQ's
   All bios settings are manual. CPU speed etc
   -X 34
   Diffrent Controlllers ide0,ide1,ide2
   
Still getting drive corruption as soon as I turn on DMA mode..  I even 
tested 2 HD's and only activating DMA on 1.  (seperate controllers) and 
the both got corrupted. 

any ideas? 






Mark Hahn wrote:

>> least 30 times now.  I have a ABIT KT7-RAID and no
> 
> 
> have you installed the latest bios, and/or turned off the 
> bugusly agressive pci-bridge settings?  they are responsible 
> for all verified kt133/ide problems reported so far.
> 
> 
> 


