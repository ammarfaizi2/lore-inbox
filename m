Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262291AbTLWTTt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 14:19:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbTLWTTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 14:19:49 -0500
Received: from peabody.ximian.com ([141.154.95.10]:43236 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262192AbTLWTTs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 14:19:48 -0500
Subject: Re: [PATCH] add sysfs mem device support  [2/4]
From: Rob Love <rml@ximian.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
In-Reply-To: <20031223191634.A8914@infradead.org>
References: <20031223002126.GA4805@kroah.com>
	 <20031223002439.GB4805@kroah.com> <20031223002609.GC4805@kroah.com>
	 <20031223131523.B6864@infradead.org> <20031223180127.GA14282@kroah.com>
	 <20031223191634.A8914@infradead.org>
Content-Type: text/plain
Message-Id: <1072207183.6015.19.camel@fur>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Tue, 23 Dec 2003 14:19:43 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-12-23 at 14:16, Christoph Hellwig wrote:

> What user-modifiable attributes?

See /proc/sys/kernel/random

Junk like that should be ripped from procfs and put in sysfs
corresponding to its device file.

	Rob Love


