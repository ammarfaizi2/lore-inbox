Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317892AbSIJSVW>; Tue, 10 Sep 2002 14:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317898AbSIJSUT>; Tue, 10 Sep 2002 14:20:19 -0400
Received: from pizda.ninka.net ([216.101.162.242]:1707 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317892AbSIJSTz>;
	Tue, 10 Sep 2002 14:19:55 -0400
Date: Tue, 10 Sep 2002 11:16:27 -0700 (PDT)
Message-Id: <20020910.111627.00809211.davem@redhat.com>
To: jgarzik@mandrakesoft.com
Cc: torvalds@transmeta.com, david-b@pacbell.net,
       mdharm-kernel@one-eyed-alien.net, greg@kroah.com,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB changes for 2.5.34
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3D7E28D3.4070200@mandrakesoft.com>
References: <Pine.LNX.4.44.0209100947481.2842-100000@home.transmeta.com>
	<3D7E28D3.4070200@mandrakesoft.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jeff Garzik <jgarzik@mandrakesoft.com>
   Date: Tue, 10 Sep 2002 13:16:03 -0400
   
   IMO we should have ASSERT() and OHSHIT(),

I fully support the addition of an OHSHIT() macro.
:-)
