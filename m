Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318069AbSIJTfN>; Tue, 10 Sep 2002 15:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318076AbSIJTfM>; Tue, 10 Sep 2002 15:35:12 -0400
Received: from pizda.ninka.net ([216.101.162.242]:31659 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318069AbSIJTe4>;
	Tue, 10 Sep 2002 15:34:56 -0400
Date: Tue, 10 Sep 2002 12:31:33 -0700 (PDT)
Message-Id: <20020910.123133.121582611.davem@redhat.com>
To: torvalds@transmeta.com
Cc: jgarzik@mandrakesoft.com, david-b@pacbell.net,
       mdharm-kernel@one-eyed-alien.net, greg@kroah.com,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB changes for 2.5.34
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0209101132320.3280-100000@home.transmeta.com>
References: <20020910.111627.00809211.davem@redhat.com>
	<Pine.LNX.4.44.0209101132320.3280-100000@home.transmeta.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Linus Torvalds <torvalds@transmeta.com>
   Date: Tue, 10 Sep 2002 11:40:27 -0700 (PDT)
   
   We'd end up with endless asserts in the networking layer, 
   just because David would find it amusing. 

:-) You know some of us do indeed miss the days of occaisionally
waking up to find things like "inode.c: the problem is here" on
our screens.
