Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264492AbUGIHQZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264492AbUGIHQZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 03:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264499AbUGIHQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 03:16:25 -0400
Received: from holomorphy.com ([207.189.100.168]:22250 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264492AbUGIHQY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 03:16:24 -0400
Date: Fri, 9 Jul 2004 00:16:05 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "David S. Miller" <davem@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-mm6
Message-ID: <20040709071605.GZ21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	"David S. Miller" <davem@redhat.com>, Ingo Molnar <mingo@elte.hu>,
	akpm@osdl.org, linux-kernel@vger.kernel.org
References: <20040706125438.GS21066@holomorphy.com> <20040706233618.GW21066@holomorphy.com> <20040706170247.5bca760c.davem@redhat.com> <20040707073510.GA27609@elte.hu> <20040707140249.2bfe0a4b.davem@redhat.com> <40EE06B1.1090202@yahoo.com.au> <20040709025151.GV21066@holomorphy.com> <40EE288F.20301@yahoo.com.au> <20040709065830.GY21066@holomorphy.com> <40EE4421.2000206@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40EE4421.2000206@yahoo.com.au>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 09, 2004 at 05:07:13PM +1000, Nick Piggin wrote:
> I don't really follow you.
> And you still haven't told me what compile errors you are getting.
> I don't have an evironment to build or test a sparc64 kernel.

--target=sparc64-linux-elf should get you out of the glibc hassles.


-- wli
