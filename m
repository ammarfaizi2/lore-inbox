Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263579AbUJ2U6Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263579AbUJ2U6Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 16:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263514AbUJ2Uwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 16:52:45 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:62353 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S263524AbUJ2UmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 16:42:00 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.5.2
From: Lee Revell <rlrevell@joe-job.com>
To: John Gilbert <jgilbert@biomail.ucsd.edu>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <41828348.4000700@biomail.ucsd.edu>
References: <OFDD5E88CA.56DEE781-ON86256F3C.0059C080-86256F3C.0059C0A2@raytheon.com>
	 <20041029162622.GA8016@elte.hu>  <41828348.4000700@biomail.ucsd.edu>
Content-Type: text/plain
Date: Fri, 29 Oct 2004 16:41:58 -0400
Message-Id: <1099082519.14209.20.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-29 at 10:52 -0700, John Gilbert wrote:
> Hello all, Ingo,
> Here's a few bugs on boot with V0.5.2, and a question: what's needed to 
> get back to the verbose latency messages of previous preempt patches 
> (see the terse second log)?

There is a setting in /proc/sys/kernel for this, don't remember what
it's called but should be pretty clear.

Lee

