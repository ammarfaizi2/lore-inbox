Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262782AbSIPTSY>; Mon, 16 Sep 2002 15:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262792AbSIPTSY>; Mon, 16 Sep 2002 15:18:24 -0400
Received: from pizda.ninka.net ([216.101.162.242]:58341 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262782AbSIPTSX>;
	Mon, 16 Sep 2002 15:18:23 -0400
Date: Mon, 16 Sep 2002 12:14:23 -0700 (PDT)
Message-Id: <20020916.121423.109699832.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: alex14641@yahoo.com, TheUnforgiven@attbi.com, linux-kernel@vger.kernel.org
Subject: Re: To Anyone with a Radeon 7500 board and the ali developer
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1032180131.1191.7.camel@irongate.swansea.linux.org.uk>
References: <20020916042625.55842.qmail@web40509.mail.yahoo.com>
	<20020915.220131.104193664.davem@redhat.com>
	<1032180131.1191.7.camel@irongate.swansea.linux.org.uk>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: 16 Sep 2002 13:42:11 +0100
   
   What is sad is the is an AGP standardised way to read this and XFree86
   still, all these years on, doesn't do it by default.
   
Totally agreed.

I have even suggested on the xfree86 developer list at least 2 times
that they do this to choose the default, but they claim it isn't the
right thing to do.

So people's boxes will keep hanging and xfree86 DRM will continue to
be a support nightmare.
