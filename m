Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751498AbWIOOPK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498AbWIOOPK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 10:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751500AbWIOOPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 10:15:10 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41650 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751498AbWIOOPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 10:15:08 -0400
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Jes Sorensen <jes@sgi.com>, Paul Mundt <lethal@linux-sh.org>,
       Karim Yaghmour <karim@opersys.com>, Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
In-Reply-To: <Pine.LNX.4.64.0609151556270.6761@scrub.home>
References: <20060914112718.GA7065@elte.hu>
	 <Pine.LNX.4.64.0609141537120.6762@scrub.home>
	 <20060914135548.GA24393@elte.hu>
	 <Pine.LNX.4.64.0609141623570.6761@scrub.home>
	 <20060914171320.GB1105@elte.hu>
	 <Pine.LNX.4.64.0609141935080.6761@scrub.home>
	 <20060914181557.GA22469@elte.hu> <4509A54C.1050905@opersys.com>
	 <yq08xkleb9h.fsf@jaguar.mkp.net> <450A9EC9.9080307@opersys.com>
	 <20060915132052.GA7843@localhost.usen.ad.jp>
	 <Pine.LNX.4.64.0609151535030.6761@scrub.home> <450AAE39.4040205@sgi.com>
	 <Pine.LNX.4.64.0609151556270.6761@scrub.home>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 15 Sep 2006 15:37:51 +0100
Message-Id: <1158331071.29932.63.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-09-15 am 16:03 +0200, ysgrifennodd Roman Zippel:
> Huh? What kind of explanation do you want?
> 
> $ grep KPROBES arch/*/Kconf*
> arch/i386/Kconfig:config KPROBES
> arch/ia64/Kconfig:config KPROBES
> arch/powerpc/Kconfig:config KPROBES
> arch/sparc64/Kconfig:config KPROBES
> arch/x86_64/Kconfig:config KPROBES

Send patches. The fact nobody has them implemented on your platform
isn't a reason to implement something else, quite the reverse in fact.

Alan

