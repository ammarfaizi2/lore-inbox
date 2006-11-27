Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758421AbWK0RFi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758421AbWK0RFi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 12:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758422AbWK0RFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 12:05:38 -0500
Received: from tomts16.bellnexxia.net ([209.226.175.4]:26517 "EHLO
	tomts16-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1758415AbWK0RFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 12:05:37 -0500
Date: Mon, 27 Nov 2006 12:05:30 -0500
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       Karim Yaghmour <karim@opersys.com>, Paul Mundt <lethal@linux-sh.org>,
       Jes Sorensen <jes@sgi.com>, Richard J Moore <richardj_moore@uk.ibm.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Douglas Niehaus <niehaus@eecs.ku.edu>, ltt-dev@shafik.org,
       systemtap@sources.redhat.com
Subject: Re: [PATCH 1/16] LTTng 0.6.36 for 2.6.18 : debugfs fix
Message-ID: <20061127170530.GA4377@Krystal>
References: <20061124215140.GB25048@Krystal> <20061127165436.GB5348@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20061127165436.GB5348@infradead.org>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 12:00:42 up 96 days, 14:08,  3 users,  load average: 0.77, 0.74, 0.94
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Christoph Hellwig (hch@infradead.org) wrote:
> On Fri, Nov 24, 2006 at 04:51:40PM -0500, Mathieu Desnoyers wrote:
> > Patch against 2.6.19-rc6 already submitted to Greg Kroah-Hartman in tiny
> > pieces for inclusion.
> 
> This doesn't look like a single fix but rather like a few of them,
> and the description is rather lacking.  But if Greg has already taken
> it we shouldn't worry..
> 

Hi Christoph,

Yes, here it's in a single chunk so a functionnal LTTng can be sent to LKML in
less than 20 posts. I submitted it in small chunks to Greg already, please see
then following posts for the detail :

[PATCH 1/5] DebugFS : inotify create/mkdir support, 2.6.19-rc6
http://lkml.org/lkml/2006/11/24/121
[PATCH 2/5] DebugFS : coding style fixes, 2.6.19-rc6
http://lkml.org/lkml/2006/11/24/120
[PATCH 3/5] DebugFS : file/directory creation error handling, 2.6.19-rc6
http://lkml.org/lkml/2006/11/24/124
[PATCH 4/5] DebugFS : file/directory creation error handling, 2.6.19-rc6
http://lkml.org/lkml/2006/11/24/125
[PATCH 5/5] DebugFS : file/directory removal fix, 2.6.19-rc6
http://lkml.org/lkml/2006/11/24/126

Mathieu

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
