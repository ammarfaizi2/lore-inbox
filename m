Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031076AbWKURAS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031076AbWKURAS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 12:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031200AbWKURAR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 12:00:17 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:61888 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1031076AbWKURAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 12:00:15 -0500
Subject: Re: Bug: Pentium M not always detected by CPUFREQ
From: Arjan van de Ven <arjan@infradead.org>
To: Holger Schurig <hs4233@mail.mn-solutions.de>
Cc: linux-kernel@vger.kernel.org, cpufreq@lists.linux.org.uk
In-Reply-To: <200611211646.29488.hs4233@mail.mn-solutions.de>
References: <200611211646.29488.hs4233@mail.mn-solutions.de>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 21 Nov 2006 18:00:12 +0100
Message-Id: <1164128412.31358.680.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-11-21 at 16:46 +0100, Holger Schurig wrote:
> Hi !
> 
> One module thinks that I have a Pentium M, the other doesn't. 
> Which module is right?

> model name      : Intel(R) Celeron(R) processor            600MHz
> stepping        : 5
> cpu MHz         : 598.093
> cache size      : 64 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 2
> wp              : yes
> flags           : fpu vme de pse tsc msr mce cx8 apic sep mtrr 
> pge mca cmov pat clflush dts acpi mmx fxsr sse sse2 tm pbe
> bogomips        : 1196.88
> 
> 
> So far I can only say that speedstep-centrino doesn't have an 
> entry for a CPU with a mere 600 MHz. May this be the problem?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

