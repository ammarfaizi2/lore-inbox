Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261415AbSJCX1V>; Thu, 3 Oct 2002 19:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261422AbSJCX1V>; Thu, 3 Oct 2002 19:27:21 -0400
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:54941 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S261415AbSJCX1U>;
	Thu, 3 Oct 2002 19:27:20 -0400
Date: Fri, 4 Oct 2002 00:35:04 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Robert Love <rml@tech9.net>
Cc: Greg KH <greg@kroah.com>, kernel <linux-kernel@vger.kernel.org>
Subject: Re: export of sys_call_table
Message-ID: <20021003233504.GA20570@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Robert Love <rml@tech9.net>, Greg KH <greg@kroah.com>,
	kernel <linux-kernel@vger.kernel.org>
References: <20021003153943.E22418@openss7.org> <20021003221525.GA2221@kroah.com> <20021003222716.GB14919@suse.de> <1033684027.1247.43.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1033684027.1247.43.camel@phantasy>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2002 at 06:27:06PM -0400, Robert Love wrote:

 > > Hmm, I guess this means oprofile has no chance of working
 > > on Red Hat's kernels ? Bummer.
 > Newer oprofile does not need the exported syscall table.

Hrmmm, HEAD CVS from a few minutes ago still does.
John's work on getting things done correctly for 2.6 doesn't
change the fact that it's buggered on Red Hat's 2.4 kernel.
Or does it ?
 
 > I believe Red Hat 8.0 even ships with oprofile :)

Interesting. Maybe I'll download a copy sometime 8)

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
