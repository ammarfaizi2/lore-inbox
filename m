Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311239AbSCRHoE>; Mon, 18 Mar 2002 02:44:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312224AbSCRHnx>; Mon, 18 Mar 2002 02:43:53 -0500
Received: from bert.webservepro.com ([198.94.136.45]:34058 "EHLO
	bert.webservepro.com") by vger.kernel.org with ESMTP
	id <S311239AbSCRHnn>; Mon, 18 Mar 2002 02:43:43 -0500
Message-Id: <200203180743.g2I7hfmj007702@bert.webservepro.com>
Content-Type: text/plain; charset=US-ASCII
From: Michael <admin@www0.org>
Reply-To: linux-kernel@vger.kernel.org
Organization: none
To: linux-kernel@vger.kernel.org
Subject: Suspicious about 2.4.18
Date: Mon, 18 Mar 2002 07:41:09 +0000
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not really a linux expert, so I can only be suspicious.

Masquerading of iptables 1.2.5 sudently idles when "iptables -L" shows 
everything is alright. A realoading of rc.firewall brings everything back to 
normal. That happened 7 days after a normal operation. I've now upgraded to 
1.2.6 and see what happens.

Also, crond doesn't seem to operate very precisely. It is sometimes seems 
idle for 30 minutes.

I know that these may be application-specific problems, but I was curious if 
there are any current kernel issues related to them so I can quit searching 
for another cure.

Thanks. Michael.
