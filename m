Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263959AbTDDTYF (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 14:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263960AbTDDTYF (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 14:24:05 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:2831 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263959AbTDDTYF (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 14:24:05 -0500
Date: Fri, 4 Apr 2003 20:35:31 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Erik Hendriks <hendriks@lanl.gov>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: Syscall numbers for BProc
Message-ID: <20030404203531.A29501@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Erik Hendriks <hendriks@lanl.gov>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <20030404193218.GD15620@lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030404193218.GD15620@lanl.gov>; from hendriks@lanl.gov on Fri, Apr 04, 2003 at 12:32:18PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 04, 2003 at 12:32:18PM -0700, Erik Hendriks wrote:
> Is it possible to get a Linux system call number allocated for BProc?
> (http://sourceforge.net/projects/bproc) I've been using arbitrary
> system call numbers for a while but there have been collisions with
> new kernel features.  I'd like to avoid that in the future.  BProc
> currently works on 2.4.x kernels on x86, alpha and ppc (32bit).

Please explain why you need syscalls and the exact APIs.

