Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317489AbSHLIDK>; Mon, 12 Aug 2002 04:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317493AbSHLIDK>; Mon, 12 Aug 2002 04:03:10 -0400
Received: from pizda.ninka.net ([216.101.162.242]:35226 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317489AbSHLIDJ>;
	Mon, 12 Aug 2002 04:03:09 -0400
Date: Mon, 12 Aug 2002 00:53:23 -0700 (PDT)
Message-Id: <20020812.005323.92129014.davem@redhat.com>
To: uzi@uzix.org
Cc: kieran@esperi.demon.co.uk, linux-kernel@vger.kernel.org
Subject: Re: Ultrasparc 1 network freeze
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020812071140.GB925@uzix.org>
References: <20020811.182923.02248401.davem@redhat.com>
	<20020812050928.GA925@uzix.org>
	<20020812071140.GB925@uzix.org>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Joshua Uziel <uzi@uzix.org>
   Date: Mon, 12 Aug 2002 00:11:41 -0700

   Damn, scratch that, dude... it definitely helps, but I just had it
   happen to me with your patch.  It's much harder to reproduce with your
   patch...
   
Is there anything interesting in the logs when it happens?
Are there any error statistics in /proc/net/dev incremented
when it happens?
