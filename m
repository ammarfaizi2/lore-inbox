Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131525AbRA2STK>; Mon, 29 Jan 2001 13:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132119AbRA2STA>; Mon, 29 Jan 2001 13:19:00 -0500
Received: from dsl081-080-099-lax1.dsl-isp.net ([64.81.80.99]:46333 "EHLO
	pelerin.serpentine.com") by vger.kernel.org with ESMTP
	id <S131525AbRA2SS5>; Mon, 29 Jan 2001 13:18:57 -0500
To: "Michael H. Warfield" <mhw@wittsend.com>
Cc: John Jasen <jjasen@datafoundation.com>,
        Mike Pontillo <mike_p@polaris.wox.org>, linux-kernel@vger.kernel.org
Subject: Re: Support for 802.11 cards?
In-Reply-To: <Pine.LNX.4.21.0101281344040.12805-100000@polaris.wox.org> <Pine.LNX.4.30.0101281704050.2343-100000@flash.datafoundation.com> <20010128182358.F23716@alcove.wittsend.com>
X-Horoscope: Your telephone will be turning in the next several days.  Two other
   people put together will think of you as the man.  Discuss life
   with RMS with the help of God.  You'll often be tall.
From: "Bryan O'Sullivan" <bos@serpentine.com>
Date: 29 Jan 2001 10:18:52 -0800
In-Reply-To: "Michael H. Warfield"'s message of "Sun, 28 Jan 2001 18:23:58 -0500"
Message-ID: <87wvbekyr7.fsf@pelerin.serpentine.com>
X-Mailer: Gnus v5.6.45/XEmacs 21.1 - "Channel Islands"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

m> The ISA bridge also works on the 2.4 kernels but I have not
m> retested the PCI bridge on 2.4.

The Lucent PCI-to-Cardbus bridge only works on machines that have a
recent PCI BIOS.  Any motherboard more than about 16 months old simply
won't find the bridge card, and hence neither will Linux.

	<b
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
