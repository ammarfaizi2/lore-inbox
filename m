Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964791AbWEJHyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964791AbWEJHyb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 03:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbWEJHyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 03:54:31 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:2788 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932301AbWEJHya (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 03:54:30 -0400
Date: Wed, 10 May 2006 09:54:20 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RT PATCH] fix futex compilation (rt20)
Message-ID: <20060510075420.GA26382@elte.hu>
References: <20060508091535.GB6081@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060508091535.GB6081@in.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Dipankar Sarma <dipankar@in.ibm.com> wrote:

> Hi Ingo,
> 
> I needed this patch to compile and boot rt20 on x86_64. Just FYI.

thanks, applied.

	Ingo
