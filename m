Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266603AbUIVSSF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266603AbUIVSSF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 14:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266611AbUIVSSE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 14:18:04 -0400
Received: from smtp-vbr15.xs4all.nl ([194.109.24.35]:57617 "EHLO
	smtp-vbr15.xs4all.nl") by vger.kernel.org with ESMTP
	id S266603AbUIVSSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 14:18:01 -0400
Date: Wed, 22 Sep 2004 20:18:00 +0200
From: Koos Vriezen <koos.vriezen@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: Javascript bug with 2.6.8.1
Message-ID: <20040922181800.GA20060@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sledgedog wrote:
> hi,
> the error occurs with any navigator and only with the kernel 2.6.8
> the javascript on an https interactive site of a bank won't
> display the full page and hang in the middle .
> But with the kernel 2.6.7 on same machine with same
> programs there is no problem the full page is displayed.
> I can reproduce the problem on different machines.
> I'd like to be personally CC'ed the answers/comments posted to the
> list in response to my posting.

Coincidence, I was bashing the #debian channel today with this problem
too. Used 'lynx -source www.iu.nl/nl' as testcase. After ignoring 
"it's ECN, you moron" and some tcpdump analyses, turned out to be 2.6.8.1
related. I really hope someone explains in this thread if 2.6.8.1 needs 
some extra configuring compared to 2.6.7 or either point to a patch or
so.

Koos
