Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264274AbTI2SQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 14:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264099AbTI2SFB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 14:05:01 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:47878 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S264096AbTI2R71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 13:59:27 -0400
Date: Mon, 29 Sep 2003 18:59:07 +0100
From: Dave Jones <davej@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Cleanup SEP errata workaround.
Message-ID: <20030929175907.GV5507@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
References: <E1A41Rq-0000N1-00@hardwired> <Pine.LNX.4.44.0309291052560.1448-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309291052560.1448-100000@home.osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 29, 2003 at 10:53:45AM -0700, Linus Torvalds wrote:
 > 
 > On Mon, 29 Sep 2003 davej@redhat.com wrote:
 > >
 > > This looks a little simpler, and has the same effect.
 > 
 > Well, "almost same". Let's hope that Intel never releases an old Pentium
 > with SEP ;)

8-) FWIW, Intel doc 24161823.pdf (Processor Identification & CPUID
instruction reference) section 3.4 does this check the same way as I did..

But lets worry about Intel being silly if/when they decide
to do so 8-)

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
