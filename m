Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751438AbWIBTnz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438AbWIBTnz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 15:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbWIBTnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 15:43:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33992 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751438AbWIBTny (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 15:43:54 -0400
Date: Sat, 2 Sep 2006 12:43:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: tglx@linutronix.de
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       Frank v Waveren <fvw@var.cx>
Subject: Re: [PATCH] prevent timespec/timeval to ktime_t overflow
Message-Id: <20060902124339.e4f22b9e.akpm@osdl.org>
In-Reply-To: <1157225306.29250.391.camel@localhost.localdomain>
References: <1156927468.29250.113.camel@localhost.localdomain>
	<20060831204612.73ed7f33.akpm@osdl.org>
	<1157100979.29250.319.camel@localhost.localdomain>
	<20060901020404.c8038837.akpm@osdl.org>
	<1157103042.29250.337.camel@localhost.localdomain>
	<20060901201305.f01ec7d2.akpm@osdl.org>
	<1157222493.29250.383.camel@localhost.localdomain>
	<1157225306.29250.391.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 02 Sep 2006 21:28:26 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> I'm quite sure right now.

Seems to work now, thanks.

-- 
VGER BF report: H 0
