Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751336AbVHXBw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbVHXBw6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 21:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbVHXBw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 21:52:58 -0400
Received: from cantor2.suse.de ([195.135.220.15]:3029 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751336AbVHXBw6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 21:52:58 -0400
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add MCE resume under ia32
References: <1124762500.3013.3.camel@linux-hp.sh.intel.com.suse.lists.linux.kernel>
	<20050823103256.GB2795@elf.ucw.cz.suse.lists.linux.kernel>
	<1124846001.3007.7.camel@linux-hp.sh.intel.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 24 Aug 2005 03:52:56 +0200
In-Reply-To: <1124846001.3007.7.camel@linux-hp.sh.intel.com.suse.lists.linux.kernel>
Message-ID: <p73pss4f6dj.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shaohua Li <shaohua.li@intel.com> writes:

> x86-64 has resume support. It uses 'on_each_cpu' in resume method, which
> is known broken. We'd better fix it.

What is broken with it? 

-Andi
