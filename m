Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264623AbUEJKqv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264623AbUEJKqv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 06:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264616AbUEJKqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 06:46:51 -0400
Received: from pop.gmx.net ([213.165.64.20]:4050 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264623AbUEJKpr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 06:45:47 -0400
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.6-mm1
Date: Mon, 10 May 2004 12:52:33 +0200
User-Agent: KMail/1.6.2
References: <20040510024506.1a9023b6.akpm@osdl.org>
In-Reply-To: <20040510024506.1a9023b6.akpm@osdl.org>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405101252.33205.dominik.karall@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  CC      arch/i386/kernel/cpu/cpufreq/p4-clockmod.o
arch/i386/kernel/cpu/cpufreq/p4-clockmod.c: In Funktion >>cpufreq_p4_get<<:
arch/i386/kernel/cpu/cpufreq/p4-clockmod.c:283: error: `sibling' undeclared 
(first use in this function)
arch/i386/kernel/cpu/cpufreq/p4-clockmod.c:283: error: (Each undeclared 
identifier is reported only once
arch/i386/kernel/cpu/cpufreq/p4-clockmod.c:283: error: for each function it 
appears in.)
make[4]: *** [arch/i386/kernel/cpu/cpufreq/p4-clockmod.o] Fehler 1

greets dominik
