Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264662AbUEJMYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264662AbUEJMYK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 08:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264661AbUEJMYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 08:24:10 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:58257 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S264662AbUEJMYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 08:24:06 -0400
Date: Mon, 10 May 2004 13:22:29 +0100
From: Dave Jones <davej@redhat.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Dominik Karall <dominik.karall@gmx.net>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-mm1
Message-ID: <20040510122229.GA8079@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Dominik Karall <dominik.karall@gmx.net>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>
References: <20040510024506.1a9023b6.akpm@osdl.org> <200405101252.33205.dominik.karall@gmx.net> <20040510111845.GB21671@redhat.com> <409F7377.3030308@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <409F7377.3030308@yahoo.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2004 at 10:20:07PM +1000, Nick Piggin wrote:

 > In -mm, cpu_sibling_map is a cpumask_t with cpu_sibling_map[cpu]
 > containing "cpu" and all of its siblings.
 > 
 > Linus' tree looks like it is going to be that way shortly too.

Ughh. Ok, I'm going to wuss out and leave that one for Andrew.
(Unless I get bored enough to go patch up a -mm tree later)
I'll worry about it in upstream cpufreq tree when it hits Linus' tree.

		Dave

