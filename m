Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274746AbRJNIMi>; Sun, 14 Oct 2001 04:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274756AbRJNIM2>; Sun, 14 Oct 2001 04:12:28 -0400
Received: from pizda.ninka.net ([216.101.162.242]:396 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S274746AbRJNIMR>;
	Sun, 14 Oct 2001 04:12:17 -0400
Date: Sun, 14 Oct 2001 01:12:46 -0700 (PDT)
Message-Id: <20011014.011246.59654800.davem@redhat.com>
To: Mika.Liljeberg@welho.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: TCP acking too fast
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3BC9441C.887258DA@welho.com>
In-Reply-To: <3BC9393D.765A156@welho.com>
	<20011014.004744.51856957.davem@redhat.com>
	<3BC9441C.887258DA@welho.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Mika Liljeberg <Mika.Liljeberg@welho.com>
   Date: Sun, 14 Oct 2001 10:51:56 +0300
   
   I don't control the remote machine, but it's linux (don't know which
   version). I tried with both HTTP (Apache 1.3.9) and FTP. I doubt it's
   the application. :-)

Well, the version of the kernel is pretty important.
Setting PSH all the time does sound like a possibly familiar bug.

Franks a lot,
David S. Miller
davem@redhat.com
