Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268564AbSIRV2D>; Wed, 18 Sep 2002 17:28:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268631AbSIRV2C>; Wed, 18 Sep 2002 17:28:02 -0400
Received: from pizda.ninka.net ([216.101.162.242]:3982 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S268564AbSIRV1U>;
	Wed, 18 Sep 2002 17:27:20 -0400
Date: Wed, 18 Sep 2002 14:22:50 -0700 (PDT)
Message-Id: <20020918.142250.130847722.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: ebiederm@xmission.com, hadi@cyberus.ca, akpm@digeo.com,
       manfred@colorfullife.com, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: Info: NAPI performance at "low" loads
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1032383727.20463.155.camel@irongate.swansea.linux.org.uk>
References: <1032381789.20498.151.camel@irongate.swansea.linux.org.uk>
	<20020918.134630.127509858.davem@redhat.com>
	<1032383727.20463.155.camel@irongate.swansea.linux.org.uk>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: 18 Sep 2002 22:15:27 +0100
   
   It doesnt matter what XFree86 is doing. Thats just to load the PCI bus
   and jam it up to prove the point. It'll change your inb timing
   
Understood.  Maybe a more accurate wording would be "a fixed minimum
timing".
