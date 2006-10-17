Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750814AbWJQGuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbWJQGuY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 02:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbWJQGuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 02:50:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42695 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750823AbWJQGuW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 02:50:22 -0400
Date: Mon, 16 Oct 2006 23:50:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Martin Bligh <mbligh@google.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [PATCH] Use min of two prio settings in calculating distress
 for reclaim
Message-Id: <20061016235012.aefd6c73.akpm@osdl.org>
In-Reply-To: <45347951.3050907@yahoo.com.au>
References: <4534323F.5010103@google.com>
	<45347951.3050907@yahoo.com.au>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Oct 2006 16:33:53 +1000
Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> And what have you done to akpm? ;)

I'm sulking.  Would prefer to bitbucket the whole ->prev_priority thing
and do something better, but I haven't got around to thinking about it yet.
