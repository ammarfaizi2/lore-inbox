Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132370AbRDNO1u>; Sat, 14 Apr 2001 10:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132372AbRDNO1k>; Sat, 14 Apr 2001 10:27:40 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:33041 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132370AbRDNO13>; Sat, 14 Apr 2001 10:27:29 -0400
Subject: Re: bizarre TCP behavior
To: stefan@hello-penguin.com
Date: Sat, 14 Apr 2001 15:27:53 +0100 (BST)
Cc: ak@suse.de (Andi Kleen), daveo@osdn.com (Dave),
        linux-kernel@vger.kernel.org
In-Reply-To: <20010414141208.A31782@stefan.sime.com> from "Stefan Traby" at Apr 14, 2001 02:12:08 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14oR1o-00051n-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> For example the Zyxel 681 SDSL-Router breaks ECN by
> stripping 0x80 (ECN Cwnd Reduced) but not 0x40 (ECN Echo)
> (TOS bits) on all SYN packets (!).
> 
> I complained because of this two times more than a month ago
> but they do not even respond.

If the router claims to be RFC compliant then you may want to investigate
trading standards bodies. In the UK at least things like the advertising 
standards agency get upset by people who claim standards compliance, are shown
not to be compliant and are not fixing things..


