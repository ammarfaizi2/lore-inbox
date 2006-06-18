Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932262AbWFRRWd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262AbWFRRWd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 13:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932266AbWFRRWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 13:22:33 -0400
Received: from xenotime.net ([66.160.160.81]:61569 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932262AbWFRRWc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 13:22:32 -0400
Date: Sun, 18 Jun 2006 10:25:17 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: 76306.1226@compuserve.com, ak@suse.de, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 2.6.16-rc6-mm2] x86: add NUMA to oops messages
Message-Id: <20060618102517.99745bf7.rdunlap@xenotime.net>
In-Reply-To: <44954B9B.6070209@linux.intel.com>
References: <200606180815_MC3-1-C2CC-41A5@compuserve.com>
	<44954B9B.6070209@linux.intel.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Jun 2006 14:48:27 +0200 Arjan van de Ven wrote:

> Chuck Ebbert wrote:
> >> and putting half of .config into the oops doesn't seem
> >> like a good long term strategy.
> > 
> > It's just this one thing; I can't think of anything else to add...
> > 
> 
> if it's compact I'd actually put the entire vermagic line there...
> it'll show compiler, preempt and a whole lot of other "distinctive" features

Yep, I like that idea too.

---
~Randy
