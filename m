Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262476AbUKQTSi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262476AbUKQTSi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 14:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262444AbUKQTRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 14:17:13 -0500
Received: from peabody.ximian.com ([130.57.169.10]:59806 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262423AbUKQTMv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 14:12:51 -0500
Subject: Re: [patch] inotify: vfs_permission was replaced
From: Robert Love <rml@novell.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: ttb@tentacle.dhs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20041117190850.GA11682@infradead.org>
References: <1100710677.6280.2.camel@betsy.boston.ximian.com>
	 <1100714560.6280.7.camel@betsy.boston.ximian.com>
	 <20041117190850.GA11682@infradead.org>
Content-Type: text/plain
Date: Wed, 17 Nov 2004 14:10:01 -0500
Message-Id: <1100718601.4981.2.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-11-17 at 19:08 +0000, Christoph Hellwig wrote:

> And using either of them was/is totally bogus.  It's a helper for filesystems,
> not a general API.

Is there some specific reason you have a problem with its use?  It works
quite nicely for what we need.

	Robert Love


