Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263294AbTKRPBH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 10:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263478AbTKRPBH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 10:01:07 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:1002 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S263294AbTKRPBF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 10:01:05 -0500
Date: Tue, 18 Nov 2003 07:01:01 -0800
From: Larry McVoy <lm@bitmover.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Larry McVoy <lm@bitmover.com>, Andrew Walrond <andrew@walrond.org>,
       linux-kernel@vger.kernel.org
Subject: Re: kernel.bkbits.net off the air
Message-ID: <20031118150101.GA10584@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Pavel Machek <pavel@ucw.cz>, Larry McVoy <lm@bitmover.com>,
	Andrew Walrond <andrew@walrond.org>, linux-kernel@vger.kernel.org
References: <fa.eto0cvm.1v20528@ifi.uio.no> <200311112021.34631.andrew@walrond.org> <20031111235215.GA22314@work.bitmover.com> <200311131010.27315.andrew@walrond.org> <20031113162712.GA2462@work.bitmover.com> <20031118095912.GA233@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031118095912.GA233@elf.ucw.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 18, 2003 at 10:59:13AM +0100, Pavel Machek wrote:
> > I suppose it sounds like we don't want to give out more free engineering
> > but let's put things into perspective.  The CVS server has about 6
> > users.
> 
> I do not know where you got that number, but its wrong. You cited 6
> unique IP addresses... I certainly did updates from more than
> _that_. But I use time rsync -zav --delete
> rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.5 ., so I'm
> probably not counted in your statistics.

"CVS server", Pavel.  That means people talking to the pserver process, not
rsync.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
