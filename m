Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261371AbSJCWSf>; Thu, 3 Oct 2002 18:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261373AbSJCWSf>; Thu, 3 Oct 2002 18:18:35 -0400
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:65178 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S261371AbSJCWSd>;
	Thu, 3 Oct 2002 18:18:33 -0400
Date: Thu, 3 Oct 2002 23:27:16 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Greg KH <greg@kroah.com>
Cc: kernel <linux-kernel@vger.kernel.org>
Subject: Re: export of sys_call_table
Message-ID: <20021003222716.GB14919@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Greg KH <greg@kroah.com>, kernel <linux-kernel@vger.kernel.org>
References: <20021003153943.E22418@openss7.org> <20021003221525.GA2221@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021003221525.GA2221@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2002 at 03:15:25PM -0700, Greg KH wrote:

 > > What is the kernel.org take on this?
 > It is a good thing that the sys_call_table is now not exported.

Hmm, I guess this means oprofile has no chance of working
on Red Hat's kernels ? Bummer.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
