Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261707AbUCPVn4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 16:43:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261731AbUCPVmn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 16:42:43 -0500
Received: from hell.org.pl ([212.244.218.42]:8455 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S261725AbUCPVmf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 16:42:35 -0500
Date: Tue, 16 Mar 2004 22:42:39 +0100
From: Karol Kozimor <sziwan@hell.org.pl>
To: johnstul@us.ibm.com, dtor_core@ameritech.net
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ACPI] X86_PM_TIMER: /proc/cpuinfo doesn't get updated
Message-ID: <20040316214239.GA28289@hell.org.pl>
Mail-Followup-To: johnstul@us.ibm.com, dtor_core@ameritech.net,
	acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20040316182257.GA2734@dreamland.darkstar.lan> <20040316194805.GC20014@picchio.gall.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <20040316194805.GC20014@picchio.gall.it>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Daniele Venzano:
> > I have a notebook with an Athlon-M CPU. I tried linux 2.6.4 with
> > CONFIG_X86_PM_TIMER=y and I noticed that /proc/cpuinfo doesn't get
> > updated when I switch frequency (via sysfs, using powernow-k7). The is
> > issue seems cosmetic only, CPU frequency changes (watching
> > temperature/battery life).
> I can confirm, I'm seeing the same behavior. Please note that the
> bogomips count gets updated, it's only the frequency that doesn't
> change.

Same here with a P4-M, follow-up to John and Dmitry.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
