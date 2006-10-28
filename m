Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752179AbWJ1LtK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752179AbWJ1LtK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 07:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752180AbWJ1LtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 07:49:10 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:35285 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1752179AbWJ1LtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 07:49:09 -0400
Date: Sat, 28 Oct 2006 12:49:08 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Alex Davis <alex14641@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: most linux friendly motherboard chipset
Message-ID: <20061028114908.GA16631@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alex Davis <alex14641@yahoo.com>, linux-kernel@vger.kernel.org
References: <20061027233223.15380.qmail@web50210.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061027233223.15380.qmail@web50210.mail.yahoo.com>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2006 at 04:32:23PM -0700, Alex Davis wrote:
> I'm preparing to build a brand new 64-bit machine, I am currently leaning toward AMD 64x2.
> I've read that NVidia, along with (silent) data corruption issues, can be a bit of a pain
> to get working under Linux. Anyone have any experience with ULi, ATI, or SiS?
> 
> Note: I'm not entirely ruling out Intel.

If you don't want builtin graphics and prefer AMD Nvidia seems to be a fair
choice.

If you however want builtin-in graphics there absolutely no way around
intel.  In fact if you want to do anything graphics-related with Linux
and intel graphics (which only comes built-in) is the only sane choice.
