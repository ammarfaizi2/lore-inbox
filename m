Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317261AbSFGJ60>; Fri, 7 Jun 2002 05:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317262AbSFGJ60>; Fri, 7 Jun 2002 05:58:26 -0400
Received: from pizda.ninka.net ([216.101.162.242]:46235 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317261AbSFGJ6Y>;
	Fri, 7 Jun 2002 05:58:24 -0400
Date: Fri, 07 Jun 2002 02:54:47 -0700 (PDT)
Message-Id: <20020607.025447.121220968.davem@redhat.com>
To: roy@karlsbakk.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: CMD-649 support? (in a hurry - please help)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200206070943.g579hhN23163@mail.pronto.tv>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
   Date: Fri, 7 Jun 2002 11:43:43 +0200
   
   He suggested using a card using the CMD-649 chipset (see link below). Is this 
   supported in Linux? Is the CMD-648 driver able to support CMD-649?
   
   http://www.cmd.com/SupportInfo.cfm?ProdID=168

Yeah the Linux driver supports them, but CMD chips in general are
pretty buggy...
