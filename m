Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbUCQKPb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 05:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbUCQKPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 05:15:31 -0500
Received: from fw.osdl.org ([65.172.181.6]:30936 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261263AbUCQKPa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 05:15:30 -0500
Date: Wed, 17 Mar 2004 02:15:31 -0800
From: Andrew Morton <akpm@osdl.org>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc1-mm1 reboots before the boot completes
Message-Id: <20040317021531.70191854.akpm@osdl.org>
In-Reply-To: <405823B2.7070500@aitel.hist.no>
References: <20040316015338.39e2c48e.akpm@osdl.org>
	<405823B2.7070500@aitel.hist.no>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting <helgehaf@aitel.hist.no> wrote:
>
>  2.6.5-rc1-mm1 didn't come up for me.

yes, there's something bad in there.

Does it help if you revert ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5-rc1/2.6.5-rc1-mm1/broken-out/early-x86-cpu-detection-fix.patch ?
