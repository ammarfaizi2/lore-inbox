Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263116AbTIAQ66 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 12:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263152AbTIAQ66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 12:58:58 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:27116 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S263116AbTIAQ6z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 12:58:55 -0400
Date: Mon, 1 Sep 2003 09:58:49 -0700
From: Larry McVoy <lm@bitmover.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
Message-ID: <20030901165849.GG1327@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Jamie Lokier <jamie@shareable.org>, Larry McVoy <lm@bitmover.com>,
	linux-kernel@vger.kernel.org
References: <20030829053510.GA12663@mail.jlokier.co.uk> <20030829154101.GB16319@work.bitmover.com> <20030901054413.GF748@mail.jlokier.co.uk> <20030901144304.GA1327@work.bitmover.com> <20030901163354.GA3556@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030901163354.GA3556@mail.jlokier.co.uk>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=1.1,
	required 7, AWL, DATE_IN_PAST_06_12, UPPERCASE_25_50)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 01, 2003 at 05:33:54PM +0100, Jamie Lokier wrote:
> Your freebsds don't what CPU they are, but let me guess..
> 
>      freebsd isn't an AMD
>      freebsd3 and freebsd4 are both AMD K6, and freebsd3 is the faster

Right you are on all points.  

freebsd:
    CPU: Unknown 80686 (400.91-MHz 686-class CPU)
    Origin = "GenuineIntel"  Id = 0x660  Stepping=0
    Features=0x183f9ff<FPU,VME,DE,PSE,TSC,MSR,PAE,MCE,CX8,SEP,MTRR,PGE,MCA,CMOV,<b16>,<b17>,MMX,<b24>>

freebsd3
    CPU: AMD-K6(tm) 3D processor (451.03-MHz 586-class CPU)
    Origin = "AuthenticAMD"  Id = 0x58c  Stepping=12
    Features=0x8021bf<FPU,VME,DE,PSE,TSC,MSR,MCE,CX8,PGE,MMX>

freebsd4
    CPU: AMD-K6tm w/ multimedia extensions (233.87-MHz 586-class CPU)
    Origin = "AuthenticAMD"  Id = 0x562  Stepping = 2
    Features=0x8001bf<FPU,VME,DE,PSE,TSC,MSR,MCE,CX8,MMX>
    AMD Features=0x400<<b10>>
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
