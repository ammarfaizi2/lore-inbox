Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267720AbUIJQms@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267720AbUIJQms (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 12:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267646AbUIJQjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 12:39:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:58311 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267561AbUIJQjI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 12:39:08 -0400
Date: Fri, 10 Sep 2004 09:39:04 -0700
From: Chris Wright <chrisw@osdl.org>
To: Tigran Aivazian <tigran@veritas.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Latest microcode data from Intel.
Message-ID: <20040910093904.R1973@build.pdx.osdl.net>
References: <1094828066.17442.4.camel@localhost.localdomain> <Pine.LNX.4.44.0409101702270.1294-100000@einstein.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0409101702270.1294-100000@einstein.homenet>; from tigran@veritas.com on Fri, Sep 10, 2004 at 05:04:35PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Tigran Aivazian (tigran@veritas.com) wrote:
> sense (as it is impossible under Linux to bind userspace app to a given 
> cpu then there is no "good" sense in which "per cpu" node can be defined).

sched_setaffinity(2) allows you to bind a userspace app to a given cpu.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
