Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261728AbUCRIM4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 03:12:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261987AbUCRIM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 03:12:56 -0500
Received: from [66.35.79.110] ([66.35.79.110]:39363 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S261728AbUCRIMz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 03:12:55 -0500
Date: Thu, 18 Mar 2004 00:12:49 -0800
From: Tim Hockin <thockin@hockin.org>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: sched_setaffinity usability
Message-ID: <20040318081249.GA26373@hockin.org>
References: <40595842.5070708@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40595842.5070708@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2004 at 12:05:22AM -0800, Ulrich Drepper wrote:
> kernel used.  In the getaffinity call this is handled nicely: the
> syscall returns the size of the type.

could you just call getaffinity first?
