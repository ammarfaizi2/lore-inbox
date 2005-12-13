Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964814AbVLMKap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964814AbVLMKap (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 05:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932614AbVLMKao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 05:30:44 -0500
Received: from cantor.suse.de ([195.135.220.2]:10130 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932576AbVLMKao (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 05:30:44 -0500
Date: Tue, 13 Dec 2005 11:30:42 +0100
From: Andi Kleen <ak@suse.de>
To: Andreas Schwab <schwab@suse.de>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>, mingo@elte.hu,
       dhowells@redhat.com, torvalds@osdl.org, hch@infradead.org,
       arjan@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-ID: <20051213103042.GV23384@wotan.suse.de>
References: <20051212161944.3185a3f9.akpm@osdl.org> <20051213075441.GB6765@elte.hu> <20051213075835.GZ15804@wotan.suse.de> <20051213004257.0f87d814.akpm@osdl.org> <20051213084926.GN23384@wotan.suse.de> <20051213010126.0832356d.akpm@osdl.org> <20051213090517.GQ23384@wotan.suse.de> <20051213011540.3070176f.akpm@osdl.org> <20051213092437.GS23384@wotan.suse.de> <jehd9d5m06.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jehd9d5m06.fsf@sykes.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2005 at 11:28:41AM +0100, Andreas Schwab wrote:
> Andi Kleen <ak@suse.de> writes:
> 
> > Haven't seen that and I still use 3.2 occasionally (it's the default
> > compiler on SLES9 and I believe on RHEL3 too)  
> 
> SLES9 has 3.3-hammer.

You're right - i meant to write SLES8 where 3.2 was default.

-Andi
