Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266115AbTLIUTv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 15:19:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266102AbTLIUSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 15:18:34 -0500
Received: from zeus.kernel.org ([204.152.189.113]:37280 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S266105AbTLIUPc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 15:15:32 -0500
Date: Tue, 9 Dec 2003 11:42:16 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Nick Piggin <piggin@cyberone.com.au>, Ingo Molnar <mingo@redhat.com>,
       Anton Blanchard <anton@samba.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] make cpu_sibling_map a cpumask_t
Message-ID: <20031209194216.GR8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Nakajima, Jun" <jun.nakajima@intel.com>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Nick Piggin <piggin@cyberone.com.au>,
	Ingo Molnar <mingo@redhat.com>, Anton Blanchard <anton@samba.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <7F740D512C7C1046AB53446D37200173341707@scsmsx402.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7F740D512C7C1046AB53446D37200173341707@scsmsx402.sc.intel.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 08, 2003 at 08:54:31PM -0800, Nakajima, Jun wrote:
> We need this sooner or later.

I somehow knew you were going to say that. =)


-- wli
