Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132414AbRDFVOL>; Fri, 6 Apr 2001 17:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132413AbRDFVOC>; Fri, 6 Apr 2001 17:14:02 -0400
Received: from [204.244.205.25] ([204.244.205.25]:3436 "HELO post.gateone.com")
	by vger.kernel.org with SMTP id <S132407AbRDFVNq>;
	Fri, 6 Apr 2001 17:13:46 -0400
Subject: Re: a quest for a better scheduler
From: Michael Peddemors <michael@linuxmagic.com>
To: Timothy "D." Witham <wookie@osdlab.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010406110603.A1599@osdlab.org>
In-Reply-To: <20010404151632.A2144@kochanski> <18230000.986424894@hellman>
	<20010405153841.A2452@osdlab.org>  <20010406110603.A1599@osdlab.org>
Content-Type: text/plain
X-Mailer: Evolution/0.10 (Preview Release)
Date: 06 Apr 2001 14:08:11 -0700
Message-Id: <986591292.11092.4.camel@mistress>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Missing an important one, our VPN's routinely run on 16 MG Ram, no HD or swap..
Loaded from an initrd on a floppy..

Don't we need to test on minimalistic machines as well :)

> So the server hardware configurations have evolved to look like 
> the following.
> 
>       1 way, 512 MB,   2 IDE
>       2 way,   1 GB,  10 SCSI (1 SCSI channel)
>       4 way,   4 GB,  20 SCSI (2 channels) 
>       8 way,   8 GB,  40 SCSI (4 channels) maybe Fibre Channel (FC)
>        16 way,  16 GB,  80 FC   (8 channels)
> 

-- 
"Catch the Magic of Linux..."
--------------------------------------------------------
Michael Peddemors - Senior Consultant
LinuxAdministration - Internet Services
NetworkServices - Programming - Security
WizardInternet Services http://www.wizard.ca
Linux Support Specialist - http://www.linuxmagic.com
--------------------------------------------------------
(604)589-0037 Beautiful British Columbia, Canada

