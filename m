Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751436AbWIOBr2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbWIOBr2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 21:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbWIOBr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 21:47:28 -0400
Received: from tomts5.bellnexxia.net ([209.226.175.25]:58537 "EHLO
	tomts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1751436AbWIOBr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 21:47:27 -0400
Date: Thu, 14 Sep 2006 21:47:26 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: Ingo Molnar <mingo@elte.hu>
Cc: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060915014726.GD23664@Krystal>
References: <20060914033826.GA2194@Krystal> <20060914112718.GA7065@elte.hu> <Pine.LNX.4.64.0609141537120.6762@scrub.home> <20060914135548.GA24393@elte.hu> <Pine.LNX.4.64.0609141623570.6761@scrub.home> <20060914171320.GB1105@elte.hu> <Pine.LNX.4.64.0609141935080.6761@scrub.home> <20060914181557.GA22469@elte.hu> <Pine.LNX.4.64.0609142038570.6761@scrub.home> <20060914202452.GA9252@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20060914202452.GA9252@elte.hu>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 21:42:17 up 22 days, 22:51,  4 users,  load average: 0.67, 0.38, 0.20
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ingo Molnar (mingo@elte.hu) wrote:
> 
> * Roman Zippel <zippel@linux-m68k.org> wrote:
> 
> > > > > also, the other disadvantages i listed very much count too. Static 
> > > > > tracepoints are fundamentally limited because:
> > > > > 
[...]
> Right now they are 
> pretty heavy cons as far as LTT goes, so obviously they have a primary 
> impact on the topic at hand (whic is whether to merge LTT or not).
> 

Ingo, why are you arguing about static instrumentation when I don't submit any
static instrumentation in my patch ? You can argue about static VS dynamic
instrumentation all you want, but please don't apply this debate to a dicision
about including or not a core tracing infrastructure that has nothing to do
with the way instrumentation or probes are inserted.

Mathieu


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
