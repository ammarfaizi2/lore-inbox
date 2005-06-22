Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262756AbVFVFhq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262756AbVFVFhq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 01:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262762AbVFVFgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 01:36:17 -0400
Received: from titan.genwebhost.com ([209.9.226.66]:57734 "EHLO
	titan.genwebhost.com") by vger.kernel.org with ESMTP
	id S262763AbVFVFTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:19:55 -0400
Date: Tue, 21 Jun 2005 22:19:51 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc6-mm1 oops on startup.
Message-Id: <20050621221951.26b86e6f.rdunlap@xenotime.net>
In-Reply-To: <42B46C18.2030101@superbug.demon.co.uk>
References: <42B46C18.2030101@superbug.demon.co.uk>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - titan.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Jun 2005 19:46:48 +0100 James Courtier-Dutton wrote:

| Hi,
| 
| I have used the kernel.org normal kernel, and it compiles and boots fine.
| I then use exactly the same .config file for the 2.6.12-rc6-mm1 and it
| fails to boot.
| 
| I attach the oops.txt that I captures via the serial port.
| 
| Can anybody help, because I wish to test the PCMCIA code.

Hi,

What does 2.6.12 do when you try to boot it?
and 2.6.12-mm1 ?

Can you also post a working/booting kernel log so that we
can compare them?

Thanks,
---
~Randy
