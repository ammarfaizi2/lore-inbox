Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136841AbREJQiT>; Thu, 10 May 2001 12:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136842AbREJQiJ>; Thu, 10 May 2001 12:38:09 -0400
Received: from pc-25-211.mountaincable.net ([24.215.25.211]:61592 "HELO
	adrock.vbfx.com") by vger.kernel.org with SMTP id <S136841AbREJQh6>;
	Thu, 10 May 2001 12:37:58 -0400
Message-ID: <3AFAC3E2.6BA7D8C0@vbfx.com>
Date: Thu, 10 May 2001 12:37:54 -0400
From: Adam <adam@vbfx.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 8139too v0.9.17 - w/ 8139B, DFE538TX 10/100 [NOT working]
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using DHCP, on Slackware 7.1 w/ GLIBC 2.2, kernel 2.4.4(and 2.4.5pre1 w/
8139too.patch to v0.9.17)
---
media is unconnected, link down, or incompatible connection
---

Is the exact message I get, though, with the v0.9.15c version of the
driver, my NIC works perfectly fine, should I revert to using kernel
2.4.3 w/ v0.9.15c of the 8139too driver until it is fixed?

If there is anymore information needed to help in possibly fixing the
problem I'd be more than glad to oblige.
-- 
Adam
adam@vbfx.com
Linux user #190288
