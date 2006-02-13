Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751210AbWBMLzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbWBMLzE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 06:55:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbWBMLzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 06:55:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:28646 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751210AbWBMLzB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 06:55:01 -0500
Date: Mon, 13 Feb 2006 03:53:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: zippel@linux-m68k.org, tglx@linutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/13] hrtimer: remove useless const
Message-Id: <20060213035354.65b04c15.akpm@osdl.org>
In-Reply-To: <20060213114612.GA30500@elte.hu>
References: <Pine.LNX.4.61.0602130209340.23804@scrub.home>
	<1139830116.2480.464.camel@localhost.localdomain>
	<Pine.LNX.4.61.0602131235180.30994@scrub.home>
	<20060213114612.GA30500@elte.hu>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> your patch makes code larger on gcc3.

By 120 bytes here.  I dropped the patch.
