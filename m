Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317506AbSIENUw>; Thu, 5 Sep 2002 09:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317508AbSIENUv>; Thu, 5 Sep 2002 09:20:51 -0400
Received: from pizda.ninka.net ([216.101.162.242]:20201 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317506AbSIENUv>;
	Thu, 5 Sep 2002 09:20:51 -0400
Date: Thu, 05 Sep 2002 06:17:34 -0700 (PDT)
Message-Id: <20020905.061734.27237914.davem@redhat.com>
To: paubert@iram.es
Cc: lk@tantalophile.demon.co.uk, taka@valinux.co.jp, hpa@zytor.com,
       linux-kernel@vger.kernel.org
Subject: Re: TCP Segmentation Offloading (TSO)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0209051334280.13338-100000@gra-lx1.iram.es>
References: <20020905121717.A15540@kushida.apsleyroad.org>
	<Pine.LNX.4.33.0209051334280.13338-100000@gra-lx1.iram.es>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Gabriel Paubert <paubert@iram.es>
   Date: Thu, 5 Sep 2002 15:21:01 +0200 (CEST)
   
   it is in the out of mainline code path for odd buffer addresses

This happens to occur every packet for pppoe users BTW.
