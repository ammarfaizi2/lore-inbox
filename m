Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319425AbSIFXzV>; Fri, 6 Sep 2002 19:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319426AbSIFXzV>; Fri, 6 Sep 2002 19:55:21 -0400
Received: from pizda.ninka.net ([216.101.162.242]:50057 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S319425AbSIFXzU>;
	Fri, 6 Sep 2002 19:55:20 -0400
Date: Fri, 06 Sep 2002 16:52:44 -0700 (PDT)
Message-Id: <20020906.165244.03972708.davem@redhat.com>
To: tcw@tempest.prismnet.com
Cc: hadi@cyberus.ca, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200209062356.g86Nu4Gk016944@tempest.prismnet.com>
References: <Pine.GSO.4.30.0209051648020.17973-100000@shell.cyberus.ca>
	<200209062356.g86Nu4Gk016944@tempest.prismnet.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Troy Wilson <tcw@tempest.prismnet.com>
   Date: Fri, 6 Sep 2002 18:56:04 -0500 (CDT)

       4241408 segments retransmited

Is hw flow control being negotiated and enabled properly on the
gigabit interfaces?

There should be no reason for these kinds of retransmits to
happen.
