Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311752AbSFTIPW>; Thu, 20 Jun 2002 04:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311898AbSFTIPV>; Thu, 20 Jun 2002 04:15:21 -0400
Received: from pizda.ninka.net ([216.101.162.242]:54452 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S311752AbSFTIPU>;
	Thu, 20 Jun 2002 04:15:20 -0400
Date: Thu, 20 Jun 2002 01:09:07 -0700 (PDT)
Message-Id: <20020620.010907.120151704.davem@redhat.com>
To: rmk@arm.linux.org.uk
Cc: rml@tech9.net, george@mvista.com, kuznet@ms2.inr.ac.ru,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace timer_bh with tasklet
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020620091115.A6313@flint.arm.linux.org.uk>
References: <1024538005.922.70.camel@sinai>
	<20020619.185514.52961715.davem@redhat.com>
	<20020620091115.A6313@flint.arm.linux.org.uk>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Russell King <rmk@arm.linux.org.uk>
   Date: Thu, 20 Jun 2002 09:11:16 +0100
   
   You appear to have missed willy's posting a couple of days ago
   fixing up the serial driver BHs.

Did it get applied to 2.5.x?
