Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264756AbUEYTuf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264756AbUEYTuf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 15:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265080AbUEYTue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 15:50:34 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:25481 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S264756AbUEYTt5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 15:49:57 -0400
Message-ID: <40B3A35D.4020702@colorfullife.com>
Date: Tue, 25 May 2004 21:49:49 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: 4g/4g for 2.6.6
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo wrote:

>also, the 4:4 overhead is really a hardware problem - and there are
>x86-compatible CPUs (amd64) where the TLB flush problem has already been
>solved: on amd64 the 4:4 feature has no noticeable overhead.
>
Do you have an idea why amd64 is better for 4g4g? Which benchmark did 
you use for testing?

--
    Manfred


