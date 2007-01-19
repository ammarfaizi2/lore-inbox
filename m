Return-Path: <linux-kernel-owner+w=401wt.eu-S964916AbXASVaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964916AbXASVaq (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 16:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964920AbXASVaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 16:30:46 -0500
Received: from smtp.osdl.org ([65.172.181.24]:41016 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964916AbXASVap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 16:30:45 -0500
Date: Fri, 19 Jan 2007 13:30:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: Michael Reed <mdr@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] optimize o_direct on block device - v3
Message-Id: <20070119133045.309367a2.akpm@osdl.org>
In-Reply-To: <45B10A6D.7030500@sgi.com>
References: <000101c7198d$9a9fde40$ff0da8c0@amr.corp.intel.com>
	<45A68E55.10601@sgi.com>
	<20070111112901.28085adf.akpm@osdl.org>
	<45B10A6D.7030500@sgi.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, 19 Jan 2007 12:14:05 -0600 Michael Reed <mdr@sgi.com> wrote:
> Thanks again for finding the fix to the problem I reported.
> Can you tell me when I might expect this fix to show up in
> 2.6.20-rc?

next week..
