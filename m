Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750909AbWINPy3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750909AbWINPy3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 11:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750910AbWINPy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 11:54:29 -0400
Received: from tomts20.bellnexxia.net ([209.226.175.74]:47085 "EHLO
	tomts20-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1750907AbWINPy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 11:54:28 -0400
Date: Thu, 14 Sep 2006 11:54:27 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 10/11] LTTng-core 0.5.108 : relayfs
Message-ID: <20060914155427.GE29906@Krystal>
References: <20060914034940.GK2194@Krystal> <20060914075353.GE7425@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20060914075353.GE7425@kernel.dk>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 11:53:45 up 22 days, 13:02,  9 users,  load average: 0.78, 0.53, 0.31
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jens Axboe (axboe@kernel.dk) wrote:
> On Wed, Sep 13 2006, Mathieu Desnoyers wrote:
> > 10 - Forward port of RelayFS 2.6.16 API, plus some enhancements.
> > patch-2.6.17-lttng-core-0.5.108-relayfs.diff
> 
> One big question - why?!
> 
(repeated)
It's a temporary solution only used because relayfs has been such
a moving target lately that I decided to wait for things to settle down before
switching. I plan to switch to the new relay.o and use DebugFS for filesystem.
I just haven't done the change yet.

Mathieu


> -- 
> Jens Axboe
> 
OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
