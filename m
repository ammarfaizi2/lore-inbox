Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271177AbTGWJDf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 05:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271178AbTGWJDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 05:03:35 -0400
Received: from 69.Red-217-126-207.pooles.rima-tde.net ([217.126.207.69]:16398
	"EHLO server01.nullzone.prv") by vger.kernel.org with ESMTP
	id S271177AbTGWJDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 05:03:34 -0400
Message-Id: <5.2.1.1.2.20030723111733.00c40870@192.168.2.130>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Wed, 23 Jul 2003 11:18:45 +0200
To: David Zaffiro <davzaffiro@netscape.net>
From: system_lists@nullzone.org
Subject: Re: Problems with IDE - Ultra-ATA devices on a SiI chipset IDE
  controler
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3F1D232B.2050200@netscape.net>
References: <5.2.1.1.2.20030721173557.00d56450@192.168.2.130>
 <5.2.1.1.2.20030721173557.00d56450@192.168.2.130>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello David,

     thanks for the reply!

     As its a production server im not using any power management as you said.

Thanks again.

Regards

At 13:42 22/07/2003 +0200, David Zaffiro wrote:
>>    I have a production server with a SiI680 pci device being used as a 
>> IDE controller.
>>    Connected to the external IDE controller I have 4 120GB IDE disks 
>> just in raid5 Linux-software mode.
>>Well, I have detected some problems that i cannot understand (I am not a 
>>expert so ... :-( ) ...
>>( I was using a HighPoint some time ago which gave me the same problems.
>
>Some time ago, I've had the same problem booting gentoo-1.4-rc2 with my 
>Promise PDC20276, I had to append "acpi=off", otherwise the kernel-image 
>of the cdrom suffered from the same problems... Maybe that'll help to get 
>your production-server back online?
>However, I couldn't determine whether you are using ACPI, perhaps not. 
>Personally, I wouldn't choose to use power-management (neither apm nor 
>acpi) on a server in the first place, but that's just me...
>




