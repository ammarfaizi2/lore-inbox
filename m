Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129810AbQLNB4E>; Wed, 13 Dec 2000 20:56:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129860AbQLNBzz>; Wed, 13 Dec 2000 20:55:55 -0500
Received: from [204.244.205.25] ([204.244.205.25]:53864 "HELO post.gateone.com")
	by vger.kernel.org with SMTP id <S129810AbQLNBzl>;
	Wed, 13 Dec 2000 20:55:41 -0500
From: Michael Peddemors <michael@linuxmagic.com>
Organization: LinuxMagic Inc.
To: Joseph Cheek <joseph@cheek.com>, linux-kernel@vger.kernel.org
Subject: Re: test12: eth0 trasmit timed out after one hour uptime
Date: Wed, 13 Dec 2000 18:34:11 -0800
X-Mailer: KMail [version 1.1.95.0]
Content-Type: text/plain
In-Reply-To: <3A37FFC9.19F05305@cheek.com>
In-Reply-To: <3A37FFC9.19F05305@cheek.com>
MIME-Version: 1.0
Message-Id: <0012131834110F.19494@mistress>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wasted time trying to track something similar down, replaced the card 
instead :> My first clue was when smacking the box, it started working 
again... (j/k)

You didna' mention the card type ...

On Wed, 13 Dec 2000, Joseph Cheek wrote:
> hi all,
>
> after about an hour of uptime [and heavy HD usage] my ethernet just
> died.  couldn't ping a thing.  syslog showed:
>
> Dec 13 14:51:46 sanfrancisco kernel: NETDEV WATCHDOG: eth0: transmit
> timed out
> Dec 13 14:51:46 sanfrancisco kernel: eth0: transmit timed out, tx_status
> 00 status e680.

-- 
--------------------------------------------------------
Michael Peddemors - Senior Consultant
Unix Administration - WebSite Hosting
Network Services - Programming
Wizard Internet Services http://www.wizard.ca
Linux Support Specialist - http://www.linuxmagic.com
--------------------------------------------------------
(604) 589-0037 Beautiful British Columbia, Canada
--------------------------------------------------------
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
