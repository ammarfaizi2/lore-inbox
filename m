Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132691AbRDOPzj>; Sun, 15 Apr 2001 11:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132692AbRDOPz3>; Sun, 15 Apr 2001 11:55:29 -0400
Received: from mercury.mv.net ([199.125.85.40]:12550 "EHLO mercury.mv.net")
	by vger.kernel.org with ESMTP id <S132691AbRDOPzR>;
	Sun, 15 Apr 2001 11:55:17 -0400
Message-ID: <001801c0c5c4$640fe8c0$0201a8c0@home>
From: "jeff millar" <jeff@wa1hco.mv.com>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <CHEKKPICCNOGICGMDODJCEODCLAA.george@gator.com>
Subject: v2.4.3 networking problem other than tcp_ecn?
Date: Sun, 15 Apr 2001 11:54:41 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Several web sites have stoped working recently about the time I upgraded to
2.4.2 - 2.4.3.  Some testing at one site showed it doesn't respond to pings
except for an occasional reply reported as "admin prohibited filter" by
tcpdump or as "packet filtered" by ping.  The kernel doesn't have tcp_ecn
compiled in, access is via ppp and dialup, everything possible compiled as
modules, iptables firewall setup.  This problem applies to machine on the
local net and to the firewall itself.

ideas?

jeff

