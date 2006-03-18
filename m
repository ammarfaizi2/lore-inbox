Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932347AbWCRJnU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347AbWCRJnU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 04:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbWCRJnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 04:43:20 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:10135 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932347AbWCRJnT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 04:43:19 -0500
Date: Sat, 18 Mar 2006 10:41:10 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch 0/8] Port of -fstack-protector to the kernel
Message-ID: <20060318094110.GB28846@elte.hu>
References: <1142611850.3033.100.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142611850.3033.100.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Arjan van de Ven <arjan@linux.intel.com> wrote:

> This patch series adds support for the gcc 4.1 -fstack-protector 
> feature to the kernel. Unfortunately this needs a gcc patch before it 
> can work, so at this point these patches are just for comment, not for 
> merging.

i think this is a neat feature, and it looks quite unintrusive. Would be 
nice to get the gcc patch merged.

	Ingo
