Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311885AbSG2HWu>; Mon, 29 Jul 2002 03:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312254AbSG2HWu>; Mon, 29 Jul 2002 03:22:50 -0400
Received: from pizda.ninka.net ([216.101.162.242]:49892 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S311885AbSG2HWn>;
	Mon, 29 Jul 2002 03:22:43 -0400
Date: Mon, 29 Jul 2002 00:13:53 -0700 (PDT)
Message-Id: <20020729.001353.112524009.davem@redhat.com>
To: davej@suse.de
Cc: alan@lxorguk.ukuu.org.uk, benh@kernel.crashing.org, andre@linux-ide.org,
       martin@dalecki.de, vojtech@suse.cz, wli@holomorphy.com,
       linux-kernel@vger.kernel.org
Subject: Re: PCI config locking (WAS Re: [RFC/CFT] cmd640 irqlocking fixes)2
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020725164807.Y16446@suse.de>
References: <20020725141811.29565@192.168.4.1>
	<1027611916.9488.79.camel@irongate.swansea.linux.org.uk>
	<20020725164807.Y16446@suse.de>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Dave Jones <davej@suse.de>
   Date: Thu, 25 Jul 2002 16:48:07 +0200

   On Thu, Jul 25, 2002 at 04:45:15PM +0100, Alan Cox wrote:
    > But does anybody but x86 uses CMD640 ? :)
    > Possibly. I don't know.
   
   ISTR these monsters appear on some Alphas too ?
   
Several Alpha's have the CMD646, which uses a different driver.  Maybe
some really really old Alpha's had the CMD640.
