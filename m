Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129353AbQKCGUD>; Fri, 3 Nov 2000 01:20:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129439AbQKCGTn>; Fri, 3 Nov 2000 01:19:43 -0500
Received: from nifty.blue-labs.org ([208.179.0.193]:46760 "EHLO
	nifty.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S129353AbQKCGTn>; Fri, 3 Nov 2000 01:19:43 -0500
Message-ID: <3A0258E9.87EBF9A0@linux.com>
Date: Thu, 02 Nov 2000 22:19:21 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dan Hollis <goemon@anime.net>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [bug] NETDEV WATCHDOG: eth0: transmit timed out
In-Reply-To: <Pine.LNX.4.21.0011022211350.30435-100000@anime.net>
Content-Type: multipart/mixed;
 boundary="------------B427AAEB88B94602F8DFA10F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------B427AAEB88B94602F8DFA10F
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Dan Hollis wrote:

> On Thu, 2 Nov 2000, David Ford wrote:
> > Ok, something happend to the tulip driver in the recent testN kernels.
> > I haven't found a reason why it happens and I can't easily reproduce it
> > but what happens is noted on the subject line.
> > I have three machines now that do this.  It's unfixable until reboot (I
> > don't have these as modules).
>
> What card, linksys lne100tx?
>
> -Dan

yep

00:13.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 20)
        Subsystem: Netgear FA310TX
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 set
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at 6200 [size=256]
        Region 1: Memory at e4001000 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at <unassigned> [disabled] [size=256K]


-d

--
"The difference between 'involvement' and 'commitment' is like an
eggs-and-ham breakfast: the chicken was 'involved' - the pig was
'committed'."



--------------B427AAEB88B94602F8DFA10F
Content-Type: text/x-vcard; charset=us-ascii;
 name="david.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for David Ford
Content-Disposition: attachment;
 filename="david.vcf"

begin:vcard 
n:Ford;David
x-mozilla-html:TRUE
org:<img src="http://www.kalifornia.com/images/paradise.jpg">
adr:;;;;;;
version:2.1
email;internet:david@kalifornia.com
title:Blue Labs Developer
x-mozilla-cpt:;-12480
fn:David Ford
end:vcard

--------------B427AAEB88B94602F8DFA10F--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
