Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131453AbQL1LOc>; Thu, 28 Dec 2000 06:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131367AbQL1LOM>; Thu, 28 Dec 2000 06:14:12 -0500
Received: from james.kalifornia.com ([208.179.68.97]:10808 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S131114AbQL1LOE>; Thu, 28 Dec 2000 06:14:04 -0500
Message-ID: <3A4B1942.D00CF7E4@linux.com>
Date: Thu, 28 Dec 2000 02:43:14 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test13-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: NETDEV WATCHDOG: eth0: transmit timed out
Content-Type: multipart/mixed;
 boundary="------------7C1B155129D870D967007439"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------7C1B155129D870D967007439
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Same old story, bugger still does it.  Have to set the link down/up to
get it running again.  I had to reset two systems tonight, one up for
~60 days, one up for two days.  Both have this card.  Unrelated traffic.

This is kernel 2.4.0-test13-pre4

00:12.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev
20)
        Subsystem: Unknown device 1385:f004
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 set
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at f800
        Region 1: Memory at fdfffc00 (32-bit, non-prefetchable)

-d


--------------7C1B155129D870D967007439
Content-Type: text/x-vcard; charset=us-ascii;
 name="david.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for David Ford
Content-Disposition: attachment;
 filename="david.vcf"

begin:vcard 
n:Ford;David
x-mozilla-html:TRUE
url:www.blue-labs.org
adr:;;;;;;
version:2.1
email;internet:david@blue-labs.org
title:Blue Labs Developer
note;quoted-printable:GPG key: http://www.blue-labs.org/david@nifty.key=0D=0A
x-mozilla-cpt:;9952
fn:David Ford
end:vcard

--------------7C1B155129D870D967007439--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
