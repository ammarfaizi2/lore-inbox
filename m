Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266627AbUGKRtV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266627AbUGKRtV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 13:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266628AbUGKRtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 13:49:21 -0400
Received: from [80.72.36.106] ([80.72.36.106]:2992 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S266627AbUGKRtT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 13:49:19 -0400
Date: Sun, 11 Jul 2004 19:49:15 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: =?ISO-8859-1?Q?Andr=E9_Goddard_Rosa?= <andre.goddard@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>, ck kernel mailing list <ck@vds.kolivas.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [ck] Re: [announce] [patch] Voluntary Kernel Preemption Patch
In-Reply-To: <b8bf377804071110291e61d19b@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0407111945030.8681@alpha.polcom.net>
References: <20040709182638.GA11310@elte.hu> <20040709195105.GA4807@infradead.org>
 <20040710124814.GA27345@elte.hu> <40F0075C.2070607@kolivas.org>
 <40F016D9.8070300@kolivas.org> <20040711064730.GA11254@elte.hu>
 <40F14E53.2030300@kolivas.org> <20040711143853.GA6555@elte.hu>
 <b8bf377804071110291e61d19b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Jul 2004, [ISO-8859-1] André Goddard Rosa wrote:

> Hi, can anyone explain this:
> 
> Using Ingo's first patch when I:
> echo 1 > /proc/sys/kernel/kernel_preempt
> 
> my system hang up after 2 seconds aproximately.

I had the same problem.


> Using Ingo's modifications + Con's it doesn't lock anymore 

Yes, my too. Maybe H3 version of Ingo's patch fixed that?

 
> and is the best kernel that I have used to test..

Yes, 2.6.7-bk20-ck5 is really the best!


Thanks,

Grzegorz Kulewski

