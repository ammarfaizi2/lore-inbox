Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbTD3KEK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 06:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261903AbTD3KEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 06:04:10 -0400
Received: from dns.toxicfilms.tv ([150.254.37.24]:59530 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S261899AbTD3KEJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 06:04:09 -0400
Date: Wed, 30 Apr 2003 12:16:23 +0200 (CEST)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: must-fix list for 2.6.0
In-Reply-To: <20030429155731.07811707.akpm@digeo.com>
Message-ID: <Pine.LNX.4.51.0304301212130.1728@dns.toxicfilms.tv>
References: <20030429155731.07811707.akpm@digeo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> kernel/
> -------
>
> - O(1) scheduler starvation, poor behaviour seems unresolved.
>
>   Jens: "I've been running 2.5.67-mm3 on my workstation for two days, and
>   it still doesn't feel as good as 2.4.  It's not a disaster like some
>   revisisons ago, but it still has occasional CPU "stalls" where it feels
>   like a process waits for half a second of so for CPU time.  That's is very
>   noticable."
Well, i had similar problems with 2.5 stalling, but now that i disabled
preemtible kernel, it is better now. Are there no complaints about preemt?

Also there is one issue, i am not sure if this may be a kernel issue,
but with setiathome running in a X desktop environment all apps work fine,
but when i run openoffice, openoffice responds with 5 second delay.
I remember somebody noticing a problem with evolution that was related to
a kernel problem. Maybe i could help sorting it out?

Regards,
Maciej

