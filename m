Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268487AbTBNVgd>; Fri, 14 Feb 2003 16:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267736AbTBNVgB>; Fri, 14 Feb 2003 16:36:01 -0500
Received: from bitmover.com ([192.132.92.2]:29365 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S268473AbTBNVeP>;
	Fri, 14 Feb 2003 16:34:15 -0500
Date: Fri, 14 Feb 2003 13:44:06 -0800
From: Larry McVoy <lm@bitmover.com>
To: Matt Reppert <arashi@yomerashi.yi.org>
Cc: Maciej Soltysiak <solt@dns.toxicfilms.tv>, linux-kernel@vger.kernel.org
Subject: Re: creating incremental diffs
Message-ID: <20030214214406.GA9095@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Matt Reppert <arashi@yomerashi.yi.org>,
	Maciej Soltysiak <solt@dns.toxicfilms.tv>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.51.0302142147360.12353@dns.toxicfilms.tv> <20030214152231.5a86d5ab.arashi@yomerashi.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030214152231.5a86d5ab.arashi@yomerashi.yi.org>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2003 at 03:22:31PM -0600, Matt Reppert wrote:
> > let's say i want to create an incremental diff between
> > 2.4.21pre4aa1 and aa2.

If you are using BK

	bk export -tpatch -rv2.4.21pre4aa1,vaa2
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
