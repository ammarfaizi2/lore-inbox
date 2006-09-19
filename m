Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751929AbWISSIJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751929AbWISSIJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 14:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751930AbWISSIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 14:08:09 -0400
Received: from tomts16.bellnexxia.net ([209.226.175.4]:41388 "EHLO
	tomts16-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1751929AbWISSIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 14:08:07 -0400
Date: Tue, 19 Sep 2006 14:03:01 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: "Jose R. Santos" <jrs@us.ibm.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Roman Zippel <zippel@linux-m68k.org>,
       Tim Bird <tim.bird@am.sony.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060919180301.GD26339@Krystal>
References: <1158323938.29932.23.camel@localhost.localdomain> <Pine.LNX.4.64.0609151425180.6761@scrub.home> <1158327696.29932.29.camel@localhost.localdomain> <450AEC92.7090409@us.ibm.com> <20060915194937.GA7133@Krystal> <450B1309.9020800@us.ibm.com> <20060915214604.GB18958@Krystal> <4510072C.7020100@us.ibm.com> <20060919153003.GA2617@Krystal> <45101D2C.8000609@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <45101D2C.8000609@us.ibm.com>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 14:02:44 up 27 days, 15:11,  4 users,  load average: 0.11, 0.12, 0.18
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jose R. Santos (jrs@us.ibm.com) wrote:
> Look like the example you propose above could also apply to this as 
> well.  You could implement some sort of debug mode to the trace data 
> that provides extra information useful for debugging the tool.  If the 
> information is really only useful when debugging the trace tool during 
> development,  wouldn't it make sense to have a way to disable debugging 
> junk as needed?
> 

You are absolutely right.

Mathieu

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
