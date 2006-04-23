Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751406AbWDWRSY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406AbWDWRSY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 13:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751432AbWDWRSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 13:18:24 -0400
Received: from www.osadl.org ([213.239.205.134]:6607 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751406AbWDWRSX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 13:18:23 -0400
Subject: Re: [PATCH] Shrink rbtree
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@osdl.org>, David Woodhouse <dwmw2@infradead.org>,
       andrea@suse.de, linux-kernel@vger.kernel.org,
       Roman Zippel <zippel@linux-m68k.org>
In-Reply-To: <1145810169.13155.6.camel@localhost.localdomain>
References: <1145623663.11909.139.camel@pmac.infradead.org>
	 <20060421180915.1f2d61a4.akpm@osdl.org>
	 <1145810169.13155.6.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sun, 23 Apr 2006 19:20:07 +0200
Message-Id: <1145812807.1322.298.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-04-23 at 12:36 -0400, Steven Rostedt wrote:
> I'm just adding Thomas Gleixner and Roman Zippel to the CC field since
> the part in question came from a debate to get rid of a state field in
> hrtimer.
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=114215996918851&w=2

David found a way to solve it already.

	tglx


