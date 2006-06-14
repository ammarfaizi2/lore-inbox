Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932321AbWFNKbf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbWFNKbf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 06:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbWFNKbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 06:31:35 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:59594 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932321AbWFNKbe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 06:31:34 -0400
Subject: Re: FOR REVIEW: New x86-64 vsyscall vgetcpu()
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org,
       libc-alpha@sourceware.org, vojtech@suse.cz
In-Reply-To: <200606140942.31150.ak@suse.de>
References: <200606140942.31150.ak@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 14 Jun 2006 11:47:21 +0100
Message-Id: <1150282041.3490.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-06-14 am 09:42 +0200, ysgrifennodd Andi Kleen:
> Comments on the general mechanism are welcome. If someone is interested in using 
> this in user space for SMP or NUMA tuning please let me know.

Will 2 words always be enough, it costs nothing to demand 8 or 16 ...

