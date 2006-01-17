Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932387AbWAQK0f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbWAQK0f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 05:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbWAQK0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 05:26:35 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:10948 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S932387AbWAQK0f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 05:26:35 -0500
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1-RC1
From: Keith Owens <kaos@ocs.com.au>
To: Dave Jones <davej@redhat.com>
cc: Andrew Morton <akpm@osdl.org>, Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, mita@miraclelinux.com
Subject: Re: [patch 2.6.15-current] i386: multi-column stack backtraces 
In-reply-to: Your message of "Tue, 17 Jan 2006 02:58:42 CDT."
             <20060117075841.GA5710@redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 17 Jan 2006 21:26:33 +1100
Message-ID: <9646.1137493593@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones (on Tue, 17 Jan 2006 02:58:42 -0500) wrote:
>On Mon, Jan 16, 2006 at 10:42:34PM -0800, Andrew Morton wrote:
>
> > Presumably this is going to bust ksymoops.
> 
>Do people actually still use ksymoops for 2.6 kernels ?
>
>I resorted to it about 6 months ago for the first time in the
>better part of 3 years, and it didn't even compile.

It compiles for me.  gcc version 4.0.2 20050901 (prerelease) (SUSE
Linux).  There are a few warnings about pointer signedness but that is
all.

