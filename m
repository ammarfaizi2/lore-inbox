Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292035AbSB0EPm>; Tue, 26 Feb 2002 23:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292005AbSB0EPX>; Tue, 26 Feb 2002 23:15:23 -0500
Received: from pizda.ninka.net ([216.101.162.242]:14464 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S292017AbSB0EPV>;
	Tue, 26 Feb 2002 23:15:21 -0500
Date: Tue, 26 Feb 2002 20:13:21 -0800 (PST)
Message-Id: <20020226.201321.39157144.davem@redhat.com>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org, jgarzik@mandrakesoft.com,
        linux-net@vger.kernel.org
Subject: Re: [BETA] First test release of Tigon3 driver
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020226172251.GA32073@kroah.com>
In-Reply-To: <20020225.165914.123908101.davem@redhat.com>
	<20020226172251.GA32073@kroah.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Greg KH <greg@kroah.com>
   Date: Tue, 26 Feb 2002 09:22:51 -0800

   Just wanted to say thanks for doing this work, the driver works great
   for me for this device:
   
   01:04.0 Ethernet controller: BROADCOM Corporation NetXtreme BCM5700 Gigabit Ethernet (rev 12)
           Subsystem: BROADCOM Corporation NetXtreme BCM5700 1000BaseTX
 ...   
   But I'm only able to run it at 10Mbit :)

Thanks for the report, but can you also show us the "dmesg" lines
that the driver printed out when the module was loaded?  That provides
more detailed probing information for us.
