Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262386AbVGMSyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262386AbVGMSyN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 14:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262340AbVGMSwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 14:52:09 -0400
Received: from mail.suse.de ([195.135.220.2]:10168 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262226AbVGMSuI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 14:50:08 -0400
Date: Wed, 13 Jul 2005 20:49:47 +0200
From: Andi Kleen <ak@suse.de>
To: Greg KH <gregkh@suse.de>
Cc: suresh.b.siddha@intel.com, ak@suse.de, linux-kernel@vger.kernel.org,
       stable@kernel.org, Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [11/11] x86_64: TASK_SIZE fixes for compatibility mode processes
Message-ID: <20050713184946.GY23737@wotan.suse.de>
References: <20050713184130.GA9330@kroah.com> <20050713184426.GM9330@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050713184426.GM9330@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2005 at 11:44:26AM -0700, Greg KH wrote:
> -stable review patch.  If anyone has any objections, please let us know.

I think the patch is too risky for stable. I had even my doubts
for mainline.

-Andi
