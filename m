Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263124AbSJGPxY>; Mon, 7 Oct 2002 11:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263134AbSJGPxY>; Mon, 7 Oct 2002 11:53:24 -0400
Received: from pizda.ninka.net ([216.101.162.242]:24218 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263126AbSJGPxX>;
	Mon, 7 Oct 2002 11:53:23 -0400
Date: Mon, 07 Oct 2002 08:52:11 -0700 (PDT)
Message-Id: <20021007.085211.83878631.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: RogerWhile@sim-basis.de, linux-kernel@vger.kernel.org
Subject: Re: Make 2.5.40-ac5 fails
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1034006265.25098.29.camel@irongate.swansea.linux.org.uk>
References: <4.3.2.7.2.20021007173756.00c5c4c0@192.168.6.2>
	<1034006265.25098.29.camel@irongate.swansea.linux.org.uk>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: 07 Oct 2002 16:57:45 +0100
   
   A lot of the ISDN layer hasn't yet been updated to the new locking,
   ditto a few bits of the netfilter code

The netfilter bits are just missing generic exports of stuff after
Ingo's threading changes.
