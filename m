Return-Path: <linux-kernel-owner+w=401wt.eu-S1161130AbWLUBvL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161130AbWLUBvL (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 20:51:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161131AbWLUBvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 20:51:10 -0500
Received: from toq3-srv.bellnexxia.net ([209.226.175.16]:37004 "EHLO
	toq3-srv.bellnexxia.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161130AbWLUBvJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 20:51:09 -0500
Date: Wed, 20 Dec 2006 18:52:16 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Christoph Hellwig <hch@infradead.org>
Cc: ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Douglas Niehaus <niehaus@eecs.ku.edu>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 0/4] Linux Kernel Markers
Message-ID: <20061220235216.GA28643@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 18:46:55 up 119 days, 20:54,  6 users,  load average: 0.65, 0.76, 0.63
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

You will find, in the following posts, the latest revision of the Linux Kernel
Markers. Due to the need some tracing projects (LTTng, SystemTAP) has of this
kind of mechanism, it could be nice to consider it for mainstream inclusion.

The following patches apply on 2.6.20-rc1-git7.

Signed-off-by : Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
