Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751339AbWJHS7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339AbWJHS7h (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 14:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbWJHS7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 14:59:37 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:14986 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751339AbWJHS7g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 14:59:36 -0400
Date: Sun, 8 Oct 2006 20:59:31 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@muc.de>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] x86_64 irq fixes
Message-ID: <20061008185931.GP14186@rhun.haifa.ibm.com>
References: <20061005212216.GA10912@rhun.haifa.ibm.com> <m11wpl328i.fsf@ebiederm.dsl.xmission.com> <20061006155021.GE14186@rhun.haifa.ibm.com> <m1d5951gm7.fsf@ebiederm.dsl.xmission.com> <20061006202324.GJ14186@rhun.haifa.ibm.com> <m1y7rtxb7z.fsf@ebiederm.dsl.xmission.com> <20061007080315.GM14186@rhun.haifa.ibm.com> <m14pugxe47.fsf@ebiederm.dsl.xmission.com> <20061007175926.GN14186@rhun.haifa.ibm.com> <m1k63budt1.fsf_-_@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1k63budt1.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 08, 2006 at 07:39:38AM -0600, Eric W. Biederman wrote:

> I have tested the code as best I can, and confirmation that this
> fixes the original problem would be great.  But I don't see how
> it could fail to fix the problem, as it restores genapic_flat to
> global vector allocation.

Works for me. Thanks, Eric.

Acked-by: Muli Ben-Yehuda <muli@il.ibm.com>

Cheers,
Muli
