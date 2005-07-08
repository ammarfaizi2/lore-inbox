Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262730AbVGHRms@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262730AbVGHRms (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 13:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262731AbVGHRms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 13:42:48 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:10193 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S262730AbVGHRmr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 13:42:47 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
Date: Fri, 8 Jul 2005 18:42:53 +0100
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <200507061257.36738.s0348365@sms.ed.ac.uk> <200507081047.07643.s0348365@sms.ed.ac.uk> <20050708114838.GA12272@elte.hu>
In-Reply-To: <20050708114838.GA12272@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507081842.53089.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 Jul 2005 12:48, Ingo Molnar wrote:
> * Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:
> > Well, just to let others who have this problem know, it's clear that
> > Ingo's rt-preempt patches increase stack pressure on systems (like
> > mine) where stack is borderline under 4K by default.
>
> btw., which gcc version are you using?
>

Not the GCC version known to bloat stacks ;-)

3.4.4, on both my machines. I'm not touching 4.x until 4.0.1 is released with 
the miscompiled-code fixes.

btw, sorry for the delay replying, busy day..

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/CSim Undergraduate
contact:    1F2 55 South Clerk Street,
            Edinburgh. EH8 9PP.
