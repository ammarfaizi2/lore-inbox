Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161535AbWHDWZW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161535AbWHDWZW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 18:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161537AbWHDWZW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 18:25:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31105 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161535AbWHDWZV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 18:25:21 -0400
Date: Fri, 4 Aug 2006 15:25:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: Andreas Schwab <schwab@suse.de>, Alexey Dobriyan <adobriyan@gmail.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: single bit flip detector.
Message-Id: <20060804152507.0abae1df.akpm@osdl.org>
In-Reply-To: <20060804220644.GA28344@redhat.com>
References: <20060801184451.GP22240@redhat.com>
	<1154470467.15540.88.camel@localhost.localdomain>
	<20060801223011.GF22240@redhat.com>
	<20060801223622.GG22240@redhat.com>
	<20060801230003.GB14863@martell.zuzino.mipt.ru>
	<20060801231603.GA5738@redhat.com>
	<jebqr4f32m.fsf@sykes.suse.de>
	<20060801235109.GB12102@redhat.com>
	<20060802001626.GA14689@redhat.com>
	<20060804141955.3139b20b.akpm@osdl.org>
	<20060804220644.GA28344@redhat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Aug 2006 18:06:44 -0400
Dave Jones <davej@redhat.com> wrote:

> Does it still work ? :-)

Awww man.  And I thought everyone _else_ was being fussy.

I expect it'll work.  We'll find out when someone hits a single-bit error.
The worst it can do is crash the machine, except it's already crashed...
