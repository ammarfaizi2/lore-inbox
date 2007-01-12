Return-Path: <linux-kernel-owner+w=401wt.eu-S1751492AbXALACW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492AbXALACW (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 19:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751516AbXALACV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 19:02:21 -0500
Received: from tomts10.bellnexxia.net ([209.226.175.54]:38940 "EHLO
	tomts10-srv.bellnexxia.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751492AbXALACV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 19:02:21 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Christoph Hellwig <hch@infradead.org>, ltt-dev@shafik.org,
       systemtap@sources.redhat.com, Douglas Niehaus <niehaus@eecs.ku.edu>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 00/05] Linux Kernel Markers
Date: Thu, 11 Jan 2007 19:02:13 -0500
Message-Id: <11685601382063-git-send-email-mathieu.desnoyers@polymtl.ca>
X-Mailer: git-send-email 1.4.4.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

You will find, in the following posts, the latest revision of the Linux Kernel
Markers. Due to the need some tracing projects (LTTng, SystemTAP) has of this
kind of mechanism, it could be nice to consider it for mainstream inclusion.

The following patches apply on 2.6.20-rc4-git3.

Signed-off-by : Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
