Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262965AbTJ3XL7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 18:11:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262971AbTJ3XL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 18:11:59 -0500
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:40711 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S262965AbTJ3XL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 18:11:56 -0500
Subject: Re: Post-halloween doc updates.
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Dave Jones <davej@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20031030141519.GA10700@redhat.com>
References: <20031030141519.GA10700@redhat.com>
Content-Type: text/plain
Message-Id: <1067555512.16868.2.camel@glass.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 31 Oct 2003 00:11:52 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-10-30 at 15:15, Dave Jones wrote:

> Process scheduler improvements.
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> - Another much talked about feature. Ingo Molnar reworked the process
>   scheduler to use an O(1) algorithm.  In operation, you should notice
>   no changes with low loads, and increased scalability with large numbers
>   of processes, especially on large SMP systems.

I think we should mention excellent Con Kolivas contributions to the 2.6
kernel scheduler. He did a great job in tunning the scheduler for
maximum interactive feeling.

