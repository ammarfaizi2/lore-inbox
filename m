Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758476AbWK0RrI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758476AbWK0RrI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 12:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758483AbWK0RrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 12:47:07 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:50851 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1758476AbWK0RrE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 12:47:04 -0500
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17771.12137.234483.862393@tut.ibm.com>
Date: Mon, 27 Nov 2006 12:33:13 -0600
To: Christoph Hellwig <hch@infradead.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       Karim Yaghmour <karim@opersys.com>, Paul Mundt <lethal@linux-sh.org>,
       Jes Sorensen <jes@sgi.com>, Richard J Moore <richardj_moore@uk.ibm.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Douglas Niehaus <niehaus@eecs.ku.edu>, ltt-dev@shafik.org,
       systemtap@sources.redhat.com, dwilder@us.ibm.com
Subject: Re: [PATCH 2/16] LTTng 0.6.36 for 2.6.18 : relay hotplug support
In-Reply-To: <20061127165513.GC5348@infradead.org>
References: <20061124215239.GC25048@Krystal>
	<20061127165513.GC5348@infradead.org>
X-Mailer: VM 7.19 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig writes:
 > On Fri, Nov 24, 2006 at 04:52:39PM -0500, Mathieu Desnoyers wrote:
 > > Patch submitted to Tom Zanussi to add hotplug support to relay.
 > 
 > I think Tom handed over relay channels maintainership to someone else.

Yeah, Dave Wilder is taking over as the contact for relay, but I'll
continue working with Mathieu on this until Dave's up to speed...

Tom


