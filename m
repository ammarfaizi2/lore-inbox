Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263405AbTDGMRm (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 08:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263407AbTDGMRm (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 08:17:42 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:39571
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263405AbTDGMRl (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 08:17:41 -0400
Subject: Re: compile error with 2.5.66-ac2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: hv <hv@trust-mart.com.cn>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030407122310.22b2023a.hv@trust-mart.com.cn>
References: <20030407122310.22b2023a.hv@trust-mart.com.cn>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049715050.2965.38.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 Apr 2003 12:30:51 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-04-07 at 05:12, hv wrote:
> Hi,
>   When I compile 2.5.66-ac2 on HP LH6000,I get the follow error:
> arch/i386/kernel/apic.c: In function `setup_local_APIC':
> arch/i386/kernel/apic.c:454: unrecognizable insn:
> (insn 541 1623 1624 (set (strict_low_part (reg:QI 2 cl [58]))
>         (const_int 0 [0x0])) -1 (insn_list:REG_DEP_OUTPUT 530 (nil))
>     (nil))
> arch/i386/kernel/apic.c:454: Internal compiler error in insn_default_length, at
> insn-attrtab.c:356

Is this repeatable ?

