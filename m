Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266531AbUIIRpS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266531AbUIIRpS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 13:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266498AbUIIRo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 13:44:26 -0400
Received: from peabody.ximian.com ([130.57.169.10]:24977 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S266531AbUIIRjf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 13:39:35 -0400
Subject: Re: What File System supports Application XIP
From: Robert Love <rml@ximian.com>
To: Tim Bird <tim.bird@am.sony.com>
Cc: arjanv@redhat.com, colin <colin@realtek.com.tw>,
       linux-kernel@vger.kernel.org
In-Reply-To: <41408B41.4030306@am.sony.com>
References: <1094723597.2801.8.camel@laptop.fenrus.com>
	 <41408B41.4030306@am.sony.com>
Content-Type: text/plain
Date: Thu, 09 Sep 2004 13:38:45 -0400
Message-Id: <1094751525.6833.61.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-09 at 09:56 -0700, Tim Bird wrote:

> Most other filesystems populate the pagecache with I/O, presumably.
> In the case of a ramfs, is the page mapped directly from the fs
> into the pagecache without a copy?

ramfs _is_ pagecache.

it is cool like that.

	Robert Love


