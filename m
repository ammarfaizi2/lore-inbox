Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315485AbSIAGIC>; Sun, 1 Sep 2002 02:08:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315748AbSIAGIC>; Sun, 1 Sep 2002 02:08:02 -0400
Received: from pizda.ninka.net ([216.101.162.242]:61119 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S315485AbSIAGIA>;
	Sun, 1 Sep 2002 02:08:00 -0400
Date: Sat, 31 Aug 2002 23:06:10 -0700 (PDT)
Message-Id: <20020831.230610.129772361.davem@redhat.com>
To: tmolina@cox.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.33-bk testing
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0208312209240.1129-100000@dad.molina>
References: <Pine.LNX.4.44.0208312209240.1129-100000@dad.molina>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Thomas Molina <tmolina@cox.net>
   Date: Sat, 31 Aug 2002 22:23:43 -0500 (CDT)

   A patch had been previously sent to the list fixing the __FUNCTION__ 
   problem in ip_nat_helper.c was missing.  It was needed before the file 
   would compile.

I've got this fixed in my tree now, and I'll push it on to
Linus.
