Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316010AbSEJOzu>; Fri, 10 May 2002 10:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316011AbSEJOzt>; Fri, 10 May 2002 10:55:49 -0400
Received: from pizda.ninka.net ([216.101.162.242]:14016 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316010AbSEJOzt>;
	Fri, 10 May 2002 10:55:49 -0400
Date: Fri, 10 May 2002 07:43:43 -0700 (PDT)
Message-Id: <20020510.074343.35536226.davem@redhat.com>
To: chen_xiangping@emc.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Tcp/ip offload card driver
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <FA2F59D0E55B4B4892EA076FF8704F553D1A42@srgraham.eng.emc.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "chen, xiangping" <chen_xiangping@emc.com>
   Date: Fri, 10 May 2002 10:48:23 -0400

   Is there any TCP offload (TOE) card driver available on Linux?
   
Why do you want it?  There is no proven performance benefit.

PCI bandwidth is the limiting factor for networking performance.
