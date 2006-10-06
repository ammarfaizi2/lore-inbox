Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422917AbWJFURL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422917AbWJFURL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 16:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422918AbWJFURL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 16:17:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29377 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422917AbWJFURJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 16:17:09 -0400
Date: Fri, 6 Oct 2006 13:15:52 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Vasquez <andrew.vasquez@qlogic.com>
cc: Andrew Morton <akpm@osdl.org>, Muli Ben-Yehuda <muli@il.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Rajesh Shah <rajesh.shah@intel.com>, Andi Kleen <ak@muc.de>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       "Luck, Tony" <tony.luck@intel.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Badari Pulavarty <pbadari@gmail.com>
Subject: Re: 2.6.19-rc1 genirq causes either boot hang or "do_IRQ: cannot
 handle IRQ -1"
In-Reply-To: <20061006200223.GT2365@n6014avq19270.qlogic.org>
Message-ID: <Pine.LNX.4.64.0610061315140.3952@g5.osdl.org>
References: <20061005212216.GA10912@rhun.haifa.ibm.com>
 <m11wpl328i.fsf@ebiederm.dsl.xmission.com> <20061006155021.GE14186@rhun.haifa.ibm.com>
 <20061006162054.GF14186@rhun.haifa.ibm.com> <20061006190039.GN2365@n6014avq19270.qlogic.org>
 <20061006124213.28afb767.akpm@osdl.org> <20061006200223.GT2365@n6014avq19270.qlogic.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 6 Oct 2006, Andrew Vasquez wrote:
>
> Patch appears to work.

Ahh, replied to Andrew too early.

Andrew, can you send that over with sign-off, and I'll apply it asap.

		Linus
