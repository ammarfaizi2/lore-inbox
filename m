Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270907AbRHNWtr>; Tue, 14 Aug 2001 18:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270917AbRHNWth>; Tue, 14 Aug 2001 18:49:37 -0400
Received: from relay01.cablecom.net ([62.2.33.101]:59403 "EHLO
	relay01.cablecom.net") by vger.kernel.org with ESMTP
	id <S270907AbRHNWtV>; Tue, 14 Aug 2001 18:49:21 -0400
Content-Type: text/plain; charset=US-ASCII
From: Christian Widmer <cwidmer@iiic.ethz.ch>
Reply-To: cwidmer@iiic.ethz.ch
To: linux-kernel@vger.kernel.org
Subject: checksumming on a DP83820
Date: Wed, 15 Aug 2001 00:49:00 +0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01081417581000.04104@asterix>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

does anybody know the DP83820 which is used on the GigaNix NIC and
can awnser me the folloing question or knows where to ask. 

the DP83820 supports IP/UDP/TCP checksumming. the chip docu say you
can mark the transmit descriptior when it contains a IP, UDP, TCP header.
1) is it possible for udp to spread multiple descriptios and the checksum
   will be calculated? 
2) if so can it be bigger than a jumboframe?

i don't find any awnsers in the chip docu from national. i think 1) could be
possible but 2) not. am i right?

thanks
chris

