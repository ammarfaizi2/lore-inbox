Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274207AbSITAxX>; Thu, 19 Sep 2002 20:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274209AbSITAwg>; Thu, 19 Sep 2002 20:52:36 -0400
Received: from holomorphy.com ([66.224.33.161]:16773 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S274207AbSITAwL>;
	Thu, 19 Sep 2002 20:52:11 -0400
Date: Thu, 19 Sep 2002 17:51:10 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ulrich Drepper <drepper@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
Message-ID: <20020920005110.GD3530@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ulrich Drepper <drepper@redhat.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <3D8A6EC1.1010809@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <3D8A6EC1.1010809@redhat.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2002 at 05:41:37PM -0700, Ulrich Drepper wrote:
>   Initial confirmations were test runs with huge numbers of threads.
>   Even on IA-32 with its limited address space and memory handling
>   running 100,000 concurrent threads was no problem at all, creating
>   and destroying the threads did not take more than two seconds.  This
>   all was made possible by the kernel work performed as part of this
>   project.

What stress tests and/or benchmarks are you using?


Thanks,
Bill
