Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751089AbWINDnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbWINDnt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 23:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbWINDnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 23:43:49 -0400
Received: from tomts43-srv.bellnexxia.net ([209.226.175.110]:16814 "EHLO
	tomts43-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1751089AbWINDns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 23:43:48 -0400
Date: Wed, 13 Sep 2006 23:38:26 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>
Cc: ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060914033826.GA2194@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 23:31:57 up 22 days, 40 min,  6 users,  load average: 0.35, 0.20, 0.11
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Following an advice Christoph gave me this summer, submitting a smaller,
easier to review patch should make everybody happier. Here is a stripped
down version of LTTng : I removed everything that would make the code
review reluctant (especially kernel instrumentation and kernel state dump
module). I plan to release this "core" version every few LTTng releases
and post it to LKML.

Comments and reviews are very welcome.

See http://ltt.polymtl.ca > QUICKSTART for information about creating your own
instrumentation set.


Mathieu


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
