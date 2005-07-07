Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261497AbVGGQyE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbVGGQyE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 12:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261478AbVGGQwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 12:52:25 -0400
Received: from chretien.genwebhost.com ([209.59.175.22]:7310 "EHLO
	chretien.genwebhost.com") by vger.kernel.org with ESMTP
	id S261471AbVGGQuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 12:50:23 -0400
Date: Thu, 7 Jul 2005 09:50:19 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: Neal Schilling <n_schilling@charter.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PPP/PPPoE/PPPoX
Message-Id: <20050707095019.7b4eff54.rdunlap@xenotime.net>
In-Reply-To: <42CD59D5.6000706@charter.net>
References: <42CD59D5.6000706@charter.net>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClamAntiVirus-Scanner: This mail is clean
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - chretien.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Jul 2005 11:35:33 -0500 Neal Schilling wrote:

| I've been digging around for quite a while and finally hoped that 
| someone here may be able to help me out. In the 2.6.12 kernel, 
| if_pppox.h changed a few items. I wanted to know if there is someone in 
| particular who maintains that particular area of the kernel, and an 
| email address for them.
| 
| Thanks,
| 
| Neal Schilling
| 
| PS:
| I'm not subscribed to this list. Please be sure to CC me with any replies.

The linux/MAINTAINERS file says:

PPP PROTOCOL DRIVERS AND COMPRESSORS
P:	Paul Mackerras
M:	paulus@samba.org
L:	linux-ppp@vger.kernel.org
S:	Maintained

PPP OVER ATM (RFC 2364)
P:	Mitchell Blank Jr
M:	mitch@sfgoth.com
S:	Maintained

PPP OVER ETHERNET
P:	Michal Ostrowski
M:	mostrows@speakeasy.net
S:	Maintained

---
~Randy
