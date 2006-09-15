Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751310AbWIOUZL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbWIOUZL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 16:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbWIOUZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 16:25:11 -0400
Received: from www.osadl.org ([213.239.205.134]:39653 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751310AbWIOUZJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 16:25:09 -0400
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: karim@opersys.com
Cc: Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Roman Zippel <zippel@linux-m68k.org>, Tim Bird <tim.bird@am.sony.com>,
       Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
       Michel Dagenais <michel.dagenais@polymtl.ca>
In-Reply-To: <450B0BF9.8090407@opersys.com>
References: <20060914033826.GA2194@Krystal>	<20060914112718.GA7065@elte.hu>
	 <Pine.LNX.4.64.0609141537120.6762@scrub.home>
	 <20060914135548.GA24393@elte.hu>
	 <Pine.LNX.4.64.0609141623570.6761@scrub.home>
	 <20060914171320.GB1105@elte.hu>
	 <Pine.LNX.4.64.0609141935080.6761@scrub.home>
	 <20060914181557.GA22469@elte.hu>	<4509B03A.3070504@am.sony.com>
	 <1158320406.29932.16.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0609151339190.6761@scrub.home>
	 <1158323938.29932.23.camel@localhost.localdomain>
	 <20060915104527.89396eaf.akpm@osdl.org>	<450AEDF2.3070504@opersys.com>
	 <20060915125934.6c82b625.akpm@osdl.org>  <450B0BF9.8090407@opersys.com>
Content-Type: text/plain
Date: Fri, 15 Sep 2006 22:25:58 +0200
Message-Id: <1158351958.5724.510.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-15 at 16:24 -0400, Karim Yaghmour wrote:
> Should this mechanism ever be made to work, the need for static
> markup would still be felt however.

This might apply to some exotic points, but for 98% of the
instrumentation scenarios static markup is not necessary.

	tglx


