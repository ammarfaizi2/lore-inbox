Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751764AbWGBDjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751764AbWGBDjv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 23:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751803AbWGBDjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 23:39:51 -0400
Received: from xenotime.net ([66.160.160.81]:8354 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751764AbWGBDju (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 23:39:50 -0400
Date: Sat, 1 Jul 2006 20:42:36 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Stephen.Clark@seclark.us
Cc: linux-kernel@vger.kernel.org
Subject: Re: isa_memcpy_fromio
Message-Id: <20060701204236.33a3df32.rdunlap@xenotime.net>
In-Reply-To: <44A732E3.10202@seclark.us>
References: <44A732E3.10202@seclark.us>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 01 Jul 2006 22:43:47 -0400 Stephen Clark wrote:

> Hello,
> 
> what has isa_memcpy_fromio() changed to in kernel 2.6.17 from 2.6.16

It was removed since there are no in-kernel users of it.

---
~Randy
