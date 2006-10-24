Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161118AbWJXRtF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161118AbWJXRtF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 13:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161120AbWJXRtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 13:49:05 -0400
Received: from smtp-out.google.com ([216.239.33.17]:51483 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1161118AbWJXRtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 13:49:04 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=mQLWcAlOgNEhniUY/JYPpkMAI7UBH0U0ZkkqiXB/JECyenDOwvPtfbvprQkS4ixeA
	7q+uPu1uJs0FPYQaDdHRw==
Message-ID: <65dd6fd50610241048h24af39d9ob49c3816dfe1ca64@mail.gmail.com>
Date: Tue, 24 Oct 2006 10:48:52 -0700
From: "Ollie Wild" <aaw@google.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Removing MAX_ARG_PAGES (request for comments/assistance)
Cc: parisc-linux@lists.parisc-linux.org, "Linus Torvalds" <torvalds@osdl.org>,
       "Arjan van de Ven" <arjan@infradead.org>, "Ingo Molnar" <mingo@elte.hu>,
       linux-mm@kvack.org, "Andrew Morton" <akpm@osdl.org>,
       "Andi Kleen" <ak@muc.de>, linux-arch@vger.kernel.org,
       "David Howells" <dhowells@redhat.com>,
       "Peter Zijlstra" <a.p.zijlstra@chello.nl>
In-Reply-To: <65dd6fd50610111448q7ff210e1nb5f14917c311c8d4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <65dd6fd50610101705t3db93a72sc0847cd120aa05d3@mail.gmail.com>
	 <1160572460.2006.79.camel@taijtu>
	 <65dd6fd50610111448q7ff210e1nb5f14917c311c8d4@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's been a couple weeks since I got any feedback on this.  I just
wanted to send out a gentle reminder to encourage people to take a
look.

I realize the kernel is in bugfix mode at the moment.  If people would
rather I resend after the 2.6.19 release, please let me know.

Thanks,
Ollie
