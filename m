Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263293AbTC0QUP>; Thu, 27 Mar 2003 11:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263294AbTC0QUP>; Thu, 27 Mar 2003 11:20:15 -0500
Received: from bitmover.com ([192.132.92.2]:51379 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S263293AbTC0QUO>;
	Thu, 27 Mar 2003 11:20:14 -0500
Date: Thu, 27 Mar 2003 08:31:20 -0800
From: Larry McVoy <lm@bitmover.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: ECC error in 2.5.64 + some patches
Message-ID: <20030327163120.GC29195@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"Randy.Dunlap" <rddunlap@osdl.org>, Larry McVoy <lm@bitmover.com>,
	linux-kernel@vger.kernel.org
References: <20030324212813.GA6310@osiris.silug.org> <20030324180107.A14746@vger.timpanogas.org> <20030324234410.GB10520@work.bitmover.com> <20030324182508.A15039@vger.timpanogas.org> <20030327160220.GA29195@work.bitmover.com> <20030327082212.252159e0.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030327082212.252159e0.rddunlap@osdl.org>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> | Message from syslogd@slovax at Thu Mar 27 05:53:49 2003 ...
> | slovax kernel: Bank 1: 9000000000000151
> 
> You can try the Dave Jones "parsemce" tool on it, from
>   http://www.codemonkey.org.uk/cruft/parsemce.c/

slovax /tmp a.out -b 1 -e 9000000000000151
Status: (-8070450532247928495) Restart IP valid.

What does that mean?
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
