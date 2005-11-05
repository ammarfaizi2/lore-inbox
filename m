Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751307AbVKEHOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbVKEHOE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 02:14:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbVKEHOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 02:14:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:17327 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751307AbVKEHOB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 02:14:01 -0500
Date: Fri, 4 Nov 2005 23:13:20 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: Simon.Derr@bull.net, pj@sgi.com, ak@suse.de, linux-kernel@vger.kernel.org,
       clameter@sgi.com
Subject: Re: [PATCH 5/5] cpuset: memory reclaim rate meter
Message-Id: <20051104231320.6c4525a8.akpm@osdl.org>
In-Reply-To: <20051104053153.549.83350.sendpatchset@jackhammer.engr.sgi.com>
References: <20051104053109.549.76824.sendpatchset@jackhammer.engr.sgi.com>
	<20051104053153.549.83350.sendpatchset@jackhammer.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>
> +static ineline void cpuset_synchronous_page_reclaim_bump(void) {}

Get down and give me fifty.

I guess I'll give up and merge this thing.
