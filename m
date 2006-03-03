Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751174AbWCCXvJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbWCCXvJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 18:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbWCCXvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 18:51:09 -0500
Received: from smtp.sprintpcs.com ([68.28.27.84]:57527 "EHLO
	lswsmta01.nmcc.sprintspectrum.com") by vger.kernel.org with ESMTP
	id S1751174AbWCCXvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 18:51:08 -0500
Date: Fri, 03 Mar 2006 18:49:23 -0500
From: Chuck Martin <v4b1bze02@sneakemail.com>
Subject: Re: Realtime Kernel Slows My Clock
In-reply-to: <1141429228.3042.155.camel@mindpipe>
To: "Lee Revell rlrevell-at-joe-job.com |LKML|" 
	<1otmivksfq0t@sneakemail.com>
Cc: Chuck Martin <v4b1bze02@sneakemail.com>, linux-kernel@vger.kernel.org,
       john stultz <johnstul@us.ibm.com>, Ingo Molnar <mingo@elte.hu>
Message-id: <20060303234923.GN5458@eta>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.4.2.1i
References: <28925-53282@sneakemail.com> <1141429228.3042.155.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2006 at 06:40:27PM -0500, Lee Revell rlrevell-at-joe-job.com |LKML| wrote:
> On Fri, 2006-03-03 at 18:12 -0500, Chuck Martin wrote:
> > I've recently been trying to compile a realtime kernel for audio
> > work, and am having a problem.  The clock seems to run very slow,
> > causing my time to be off.  Commands with a delay are also slowed
> > from 10 to 30 times what they should be.  For example, "sleep 1"
> > will sometimes take up to thirty seconds. 
> 
> Please post your kernel .config.  Is this a dual core AMD?

No, it's a pentium III.  Which kernel would you like the .config from?
I have them for 2.6.13, 2.6.14, and 2.6.15 (patched, of course).

Chuck

