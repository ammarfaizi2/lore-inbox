Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030425AbWHOSMo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030425AbWHOSMo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 14:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030431AbWHOSMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 14:12:44 -0400
Received: from hera.kernel.org ([140.211.167.34]:62397 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1030425AbWHOSMn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 14:12:43 -0400
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: Maximum number of processes in Linux
Date: Tue, 15 Aug 2006 11:12:12 -0700
Organization: OSDL
Message-ID: <20060815111212.2998b318@dxpl.pdx.osdl.net>
References: <3420082f0608151059s40373a0bg4a1af3618c2b1a05@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1155665532 7620 10.8.0.74 (15 Aug 2006 18:12:12 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Tue, 15 Aug 2006 18:12:12 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 2.4.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Aug 2006 22:59:37 +0500
"Irfan Habib" <irfan.habib@gmail.com> wrote:

> Hi,
> 
> What is the maximum number of process which can run simultaneously in
> linux? I need to create an application which requires 40,000 threads.
> I was testing with far fewer numbers than that, I was getting
> exceptions in pthread_create

What kernel version, and glibc version?
