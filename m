Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261289AbSJCWVa>; Thu, 3 Oct 2002 18:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261339AbSJCWVa>; Thu, 3 Oct 2002 18:21:30 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:39687
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S261289AbSJCWV3>; Thu, 3 Oct 2002 18:21:29 -0400
Subject: Re: export of sys_call_table
From: Robert Love <rml@tech9.net>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Greg KH <greg@kroah.com>, kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20021003222716.GB14919@suse.de>
References: <20021003153943.E22418@openss7.org>
	<20021003221525.GA2221@kroah.com>  <20021003222716.GB14919@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Oct 2002 18:27:06 -0400
Message-Id: <1033684027.1247.43.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-03 at 18:27, Dave Jones wrote:

> Hmm, I guess this means oprofile has no chance of working
> on Red Hat's kernels ? Bummer.

Newer oprofile does not need the exported syscall table.

I believe Red Hat 8.0 even ships with oprofile :)

	Robert Love

