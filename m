Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319430AbSH3AKl>; Thu, 29 Aug 2002 20:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319482AbSH3AKk>; Thu, 29 Aug 2002 20:10:40 -0400
Received: from pizda.ninka.net ([216.101.162.242]:14249 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S319430AbSH3AKk>;
	Thu, 29 Aug 2002 20:10:40 -0400
Date: Thu, 29 Aug 2002 17:08:59 -0700 (PDT)
Message-Id: <20020829.170859.01012231.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: pavel@suse.cz, ldb@ldb.ods.org, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: [PATCH 1 / ...] i386 dynamic fixup/self modifying code
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1030663192.1326.20.camel@irongate.swansea.linux.org.uk>
References: <1030506106.1489.27.camel@ldb>
	<20020828121129.A35@toy.ucw.cz>
	<1030663192.1326.20.camel@irongate.swansea.linux.org.uk>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: 30 Aug 2002 00:19:52 +0100
   
   You generate a list of the addresses in a segment, patch them all
   and let the init freeup blow the table away

I just sent an email saying this, jinx...
