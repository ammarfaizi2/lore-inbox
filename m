Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261441AbUJaJEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261441AbUJaJEn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 04:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261413AbUJaJEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 04:04:43 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:16547 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261441AbUJaJER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 04:04:17 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andi Kleen <ak@suse.de>
Subject: Re: 2.6.10-rc1-mm2: konqueror segfaults for no reason
Date: Sun, 31 Oct 2004 10:05:08 +0100
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <200410291823.34175.rjw@sisk.pl> <200410301837.25828.rjw@sisk.pl> <20041031005313.GD19396@wotan.suse.de>
In-Reply-To: <20041031005313.GD19396@wotan.suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200410311005.08220.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 31 of October 2004 02:53, Andi Kleen wrote:
> On Sat, Oct 30, 2004 at 06:37:25PM +0200, Rafael J. Wysocki wrote:
> > On Saturday 30 of October 2004 17:52, Andi Kleen wrote:
> > > > Have you tested this on an SMP machine?  Mine is a UP.  I'll chek a 
dual 
> > > 
> > > Yes, on a Dual Opteron with web browsing.  Similar with firefox.
> > 
> > Can you, please, send me your .config?
> 
> arch/x86_64/defconfig as always.

Same thing.  Hmm.  What about gcc?  I use gcc 3.3.3 (out of SuSE 9.1).

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
