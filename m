Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266912AbUIJCPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266912AbUIJCPm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 22:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267184AbUIJCPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 22:15:42 -0400
Received: from peabody.ximian.com ([130.57.169.10]:6037 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S266912AbUIJCPF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 22:15:05 -0400
Subject: Re:  Re: What File System supports Application XIP
From: Robert Love <rml@ximian.com>
To: colin <colin@realtek.com.tw>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <011001c496db$99dc6aa0$8b1a13ac@realtek.com.tw>
References: <1094723597.2801.8.camel@laptop.fenrus.com>
	 <41408B41.4030306@am.sony.com>
	 <1094751525.6833.61.camel@betsy.boston.ximian.com>
	 <011001c496db$99dc6aa0$8b1a13ac@realtek.com.tw>
Content-Type: text/plain
Date: Thu, 09 Sep 2004 22:15:02 -0400
Message-Id: <1094782502.14935.14.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94.1 (1.5.94.1-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-09-10 at 10:12 +0800, colin wrote:

> Sorry. I donot quite understand. My English is poor... :-(
> Do you mean there wonot be another duplicated text section in RAM when
> application in Ramfs is executed?

This is correct, Colin.

Ramfs is essentially an in-memory filesystem implemented in the page
cache.

	Robert Love


