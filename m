Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266352AbUGKHAF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266352AbUGKHAF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 03:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266364AbUGKHAF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 03:00:05 -0400
Received: from mail015.syd.optusnet.com.au ([211.29.132.161]:54429 "EHLO
	mail015.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S266352AbUGKHAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 03:00:01 -0400
References: <20040709182638.GA11310@elte.hu> <20040709195105.GA4807@infradead.org> <20040710124814.GA27345@elte.hu> <40F0075C.2070607@kolivas.org> <40F016D9.8070300@kolivas.org> <20040711064730.GA11254@elte.hu>
Message-ID: <cone.1089529187.633082.20820.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: ck kernel mailing list <ck@vds.kolivas.org>, linux-kernel@vger.kernel.org
Subject: Re: Voluntary Kernel Preemption Patch
Date: Sun, 11 Jul 2004 16:59:47 +1000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar writes:

> 
> * Con Kolivas <kernel@kolivas.org> wrote:
> 
>> Ooops forgot to mention this was running reiserFS 3.6 on software
>> raid0 2x IDE with cfq elevator.
> 
> ok, reiserfs (and all journalling fs's) definitely need a look - as you
> can see from the ext3 mods in the patch. Any chance you could try ext3
> based tests? Those are the closest to my setups.

Sorry, I only have one machine to my name and I have to share it with 
both the family and testing so no such luck.

Con

