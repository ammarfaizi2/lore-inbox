Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130745AbQLYQB1>; Mon, 25 Dec 2000 11:01:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131011AbQLYQBS>; Mon, 25 Dec 2000 11:01:18 -0500
Received: from tahallah.claranet.co.uk ([212.126.138.206]:5892 "EHLO
	tahallah.clara.co.uk") by vger.kernel.org with ESMTP
	id <S130745AbQLYQBN>; Mon, 25 Dec 2000 11:01:13 -0500
Date: Mon, 25 Dec 2000 15:29:39 +0000 (GMT)
From: Alex Buell <alex.buell@tahallah.clara.co.uk>
Reply-To: <alex.buell@tahallah.clara.co.uk>
To: Mailing List - Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Netgear FA311
Message-ID: <Pine.LNX.4.30.0012251525470.451-100000@tahallah>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well now I've just set up the network and everything works a treat,
currently getting 850kb/s file transfers. Cool. Except for one thing.

In the logs I'm seeing this:

Dec 25 15:25:18 tahallah last message repeated 2 times
Dec 25 15:25:19 tahallah kernel: eth0: Something Wicked happened! 0783.
Dec 25 15:25:19 tahallah kernel: eth0: Something Wicked happened! 0780.
Dec 25 15:25:19 tahallah last message repeated 2 times
Dec 25 15:25:19 tahallah kernel: eth0: Something Wicked happened! 0580.
Dec 25 15:25:19 tahallah kernel: eth0: Something Wicked happened! 0783.
Dec 25 15:25:19 tahallah kernel: eth0: Something Wicked happened! 0780.
Dec 25 15:25:21 tahallah last message repeated 3 times
Dec 25 15:25:21 tahallah kernel: eth0: Something Wicked happened! 0783.
Dec 25 15:25:22 tahallah kernel: eth0: Something Wicked happened! 0780.

That's just a small snippet. Apart from those messages, all seems OK, but
I'm just wondering why it's getting those messages - what does those mean?

Cheers,
Alex
-- 
Huffapuff!

http://www.tahallah.clara.co.uk

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
