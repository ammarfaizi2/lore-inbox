Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132566AbRAHWIM>; Mon, 8 Jan 2001 17:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135667AbRAHWIC>; Mon, 8 Jan 2001 17:08:02 -0500
Received: from pizda.ninka.net ([216.101.162.242]:7564 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S132566AbRAHWHw>;
	Mon, 8 Jan 2001 17:07:52 -0500
Date: Mon, 8 Jan 2001 13:50:29 -0800
Message-Id: <200101082150.NAA21769@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
CC: mhvl@linuxia.ih.lucent.com, clubneon@hereintown.net,
        linux-kernel@vger.kernel.org
In-Reply-To: <E14FkM5-0005Rv-00@the-village.bc.nu> (message from Alan Cox on
	Mon, 8 Jan 2001 22:01:26 +0000 (GMT))
Subject: Re: Delay in authentication.gy
In-Reply-To: <E14FkM5-0005Rv-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: 	Mon, 8 Jan 2001 22:01:26 +0000 (GMT)
   From: Alan Cox <alan@lxorguk.ukuu.org.uk>

   > Solaris and other systems act identically.

   And have identical bad problems with auth failures.

Actually, I believe their sunrpc library uses an extended error
facility via the streams APIs that works similar to what is available
under Linux to solve this problem.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
