Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291640AbSBXWWY>; Sun, 24 Feb 2002 17:22:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291633AbSBXWWN>; Sun, 24 Feb 2002 17:22:13 -0500
Received: from pizda.ninka.net ([216.101.162.242]:56985 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S291637AbSBXWWD>;
	Sun, 24 Feb 2002 17:22:03 -0500
Date: Sun, 24 Feb 2002 14:18:56 -0800 (PST)
Message-Id: <20020224.141856.108756101.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: dalecki@evision-ventures.com, hozer@drgw.net, torvalds@transmeta.com,
        andre@linuxdiskcert.org, riel@conectiva.com.br,
        linux-kernel@vger.kernel.org
Subject: Re: Flash Back -- kernel 2.1.111
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <E16f5z8-0002id-00@the-village.bc.nu>
In-Reply-To: <3C794DC0.7040706@evision-ventures.com>
	<E16f5z8-0002id-00@the-village.bc.nu>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: Sun, 24 Feb 2002 21:15:06 +0000 (GMT)
   
   its the platform specific bus code that can find the bus speed out
   (if anyone)

some platforms in fact already calculate it :-)

