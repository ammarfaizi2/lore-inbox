Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293453AbSCKBe6>; Sun, 10 Mar 2002 20:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293454AbSCKBes>; Sun, 10 Mar 2002 20:34:48 -0500
Received: from pizda.ninka.net ([216.101.162.242]:19129 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S293453AbSCKBei>;
	Sun, 10 Mar 2002 20:34:38 -0500
Date: Sun, 10 Mar 2002 17:31:19 -0800 (PST)
Message-Id: <20020310.173119.10574769.davem@redhat.com>
To: rgooch@ras.ucalgary.ca
Cc: laforge@gnumonks.org, skraw@ithnet.com, joe@tmsusa.com,
        linux-kernel@vger.kernel.org, elsner@zrz.TU-Berlin.DE
Subject: Re: Broadcom 5700/5701 Gigabit Ethernet Adapters
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200203110114.g2B1EuG24994@vindaloo.ras.ucalgary.ca>
In-Reply-To: <200203110055.g2B0tiP24585@vindaloo.ras.ucalgary.ca>
	<20020310.170338.83978717.davem@redhat.com>
	<200203110114.g2B1EuG24994@vindaloo.ras.ucalgary.ca>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Richard Gooch <rgooch@ras.ucalgary.ca>
   Date: Sun, 10 Mar 2002 18:14:56 -0700

   I note the Intel card is pretty expensive. What are these "Addtron"
   cards I see listed on www.pricewatch.com for US$36 ?Is that a
   supported card under another name?

Probably Natsemi chipset based, it's not a good performer at all.
   

   > All the cards listed above have good GPL'd drivers available.
   
   When is the E1000 driver going to be added to the kernel?
   
It's in 2.5.x already... It will hit 2.4.x as soon as Intel's
QA signs off on what Jeff Garzik currently has (which is in VGER
2.4.x CVS branch btw if you want to check it out).

