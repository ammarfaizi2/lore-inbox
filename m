Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932299AbWABAvO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbWABAvO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 19:51:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932300AbWABAvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 19:51:13 -0500
Received: from sccrmhc12.comcast.net ([63.240.77.82]:36996 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932299AbWABAvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 19:51:13 -0500
Date: Sun, 1 Jan 2006 19:54:35 -0500
From: Kurt Wall <kwall@kurtwerks.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Kurt Wall <kwallnator@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Arjan's noinline Patch
Message-ID: <20060102005435.GB5213@kurtwerks.com>
Mail-Followup-To: Arjan van de Ven <arjan@infradead.org>,
	Kurt Wall <kwallnator@gmail.com>, linux-kernel@vger.kernel.org
References: <20060101155710.GA5213@kurtwerks.com> <1136131954.17830.40.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136131954.17830.40.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.1i
X-Operating-System: Linux 2.6.15-rc6krw
X-Woot: Woot!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 01, 2006 at 05:12:33PM +0100, Arjan van de Ven took 0 lines to write:
> On Sun, 2006-01-01 at 10:57 -0500, Kurt Wall wrote:
> > After applying Arjan's noline patch (http://www.fenrus.org/noinline), I
> > see almost a 10% reduction in the size of .text (against 2.6.15-rc6)
> 
> wow that's a lot, more than I expected actually.... 

And that's with gcc 3.4.4. As soon as I build a 4.x, I'll post numbers
for that, too.

Kurt
-- 
Every journalist has a novel in him, which is an excellent place for it.
