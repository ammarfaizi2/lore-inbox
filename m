Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964841AbVLMJMf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964841AbVLMJMf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 04:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964845AbVLMJMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 04:12:35 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:31625 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964840AbVLMJMd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 04:12:33 -0500
Date: Tue, 13 Dec 2005 10:11:46 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>, dhowells@redhat.com, torvalds@osdl.org,
       hch@infradead.org, arjan@infradead.org, matthew@wil.cx,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-ID: <20051213091146.GF10088@elte.hu>
References: <dhowells1134431145@warthog.cambridge.redhat.com> <20051212161944.3185a3f9.akpm@osdl.org> <20051213075441.GB6765@elte.hu> <20051213075835.GZ15804@wotan.suse.de> <20051213004257.0f87d814.akpm@osdl.org> <20051213084926.GN23384@wotan.suse.de> <20051213010126.0832356d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051213010126.0832356d.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.7
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.7 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> Andi Kleen <ak@suse.de> wrote:
> >
> > Can you please apply the following patch then? 
> > 
> >  Remove -Wdeclaration-after-statement
> 
> OK.
> 
> Thus far I have this:
> 
> 
> From: Andrew Morton <akpm@osdl.org>

hurray!!

This-Move-Is-Emphatically-Supported-by: Ingo Molnar <mingo@elte.hu>

	Ingo
