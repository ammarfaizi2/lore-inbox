Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268223AbUHXBHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268223AbUHXBHV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 21:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267186AbUHXBDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 21:03:47 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:38060 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S265027AbUHXBDS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 21:03:18 -0400
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] find_isa_irq_pin should not be __init
References: <Pine.LNX.4.58.0408231842220.13924@montezuma.fsmlabs.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 23 Aug 2004 19:01:54 -0600
In-Reply-To: <Pine.LNX.4.58.0408231842220.13924@montezuma.fsmlabs.com>
Message-ID: <m1y8k5wdq5.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@linuxpower.ca> writes:

> find_isa_irq_pin should not be __init now, i'm surprised this one didn't
> bite you Eric...

Actually so am I. 

Does someone have a brown paper bag?

Eric
