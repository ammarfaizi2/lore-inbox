Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129063AbQJaWsM>; Tue, 31 Oct 2000 17:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129097AbQJaWsC>; Tue, 31 Oct 2000 17:48:02 -0500
Received: from pizda.ninka.net ([216.101.162.242]:16000 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129063AbQJaWrr>;
	Tue, 31 Oct 2000 17:47:47 -0500
Date: Tue, 31 Oct 2000 14:33:37 -0800
Message-Id: <200010312233.OAA01775@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: tleete@mountain.net
CC: jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org
In-Reply-To: <39FEB5CB.C9AE37E6@mountain.net> (message from Tom Leete on Tue,
	31 Oct 2000 07:06:35 -0500)
Subject: Re: Fencepost error in ipv4/tulip?
In-Reply-To: <39FEB5CB.C9AE37E6@mountain.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Tue, 31 Oct 2000 07:06:35 -0500
   From: Tom Leete <tleete@mountain.net>

   Sometimes it almost works. I sent test10-pre6 to another
   local machine (stock rh6.2). The problem box was running
   vanilla test10-pre5, i486, gcc-2.95.2.

 ..

   I am puzzled.

I am puzzled as well.  Firstly, any change to try compiling the test10
kernels with egcs-1.1.x and see if that makes a difference (you have a
stock rh6.2 machine so doing this should not be very difficult :-)

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
