Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266286AbTBGR4s>; Fri, 7 Feb 2003 12:56:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266297AbTBGR4s>; Fri, 7 Feb 2003 12:56:48 -0500
Received: from bitmover.com ([192.132.92.2]:7066 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S266286AbTBGR4r>;
	Fri, 7 Feb 2003 12:56:47 -0500
Date: Fri, 7 Feb 2003 10:06:24 -0800
From: Larry McVoy <lm@bitmover.com>
To: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Cc: Matt Reppert <arashi@yomerashi.yi.org>, linux-kernel@vger.kernel.org
Subject: Re: glibc-2.3 [Was: Re: 2.5 changeset 1.952.4.2 corrupt in fs/jfs/inode.c]
Message-ID: <20030207180624.GA23740@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Horst von Brand <brand@jupiter.cs.uni-dortmund.de>,
	Matt Reppert <arashi@yomerashi.yi.org>,
	linux-kernel@vger.kernel.org
References: <20030206115508.4425d994.arashi@yomerashi.yi.org> <200302071618.h17GIAnG009654@eeyore.valparaiso.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302071618.h17GIAnG009654@eeyore.valparaiso.cl>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 07, 2003 at 05:18:10PM +0100, Horst von Brand wrote:
> So statically linking against glibc-2.2 crashes under glibc-2.3(-aware-kernel)?

Statically linking glibc 2.2.4 into BK will cause it to crash on some systems.
In general, we offer up the static image for people who aren't running glibc
based systems.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
