Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271012AbUJVDd0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271012AbUJVDd0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 23:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271011AbUJVDdB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 23:33:01 -0400
Received: from main.gmane.org ([80.91.229.2]:28604 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S270994AbUJVDbD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 23:31:03 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jan Rychter <jan@rychter.com>
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
Date: Thu, 21 Oct 2004 21:30:06 -0700
Message-ID: <m2wtxj74tt.fsf@tnuctip.rychter.com>
References: <4176E08B.2050706@techsource.com>
	<4177DF15.8010007@techsource.com> <4177E50F.9030702@sover.net>
	<200410220238.13071.jk-lkml@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 66-27-68-14.san.rr.com
X-Spammers-Please: blackholeme@rychter.com
User-Agent: Gnus/5.110003 (No Gnus v0.3) XEmacs/21.5 (chayote, linux)
Cancel-Lock: sha1:lw7bM8MufZgOUu3nLglQ094Uako=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jan" == Jan Knutar <jk-lkml@sci.fi> writes:
 Jan> On Thursday 21 October 2004 19:34, Stephen Wille Padnos wrote:
 >> I'm thinking more like microcode.  The functional blocks on the chip
 >> would be capable of being "rewired" by the OS, depending on the
 >> applications being run.  All of the functions would still operate
 >> out of card-local memory.

 Jan> Are you thinking something along the lines of an
 Jan> optimizing+profiling host-CPU-software-renderer to
 Jan> FPGA-reprogrammed JIT accelerator? :)

 Jan> The idea of reprogramming the hardware to toss out the line
 Jan> drawing and other things that GTK and friends probably only
 Jan> present to X as pixmaps anyway, and use that 'die space' for
 Jan> something else, is certainly appealing.

 Jan> Of course, for a software -> hardware JITc, I think the budget
 Jan> required would be a few magnitudes more than mentioned here
 Jan> earlier, and half a decade of debugging or more ontop..

This isn't *strictly* related to the main topic of this discussion, but:
You might want to look at the Stretch CPU (http://www.stretchinc.com/),
which, incidentally, runs Linux. Or rather the Xtensa part of it does.

--J.

