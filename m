Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262594AbTJIV1q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 17:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbTJIV1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 17:27:46 -0400
Received: from mailwasher.lanl.gov ([192.16.0.25]:5807 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S262594AbTJIV1P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 17:27:15 -0400
Subject: Re: [Fastboot] kexec update (2.6.0-test7)
From: Steven Cole <elenstev@mesatop.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Cherry George Mathew <cherry@sdf.lonestar.org>,
       "Randy.Dunlap" <rddunlap@osdl.org>, fastboot@osdl.org,
       lkml <linux-kernel@vger.kernel.org>, Hans Reiser <reiser@namesys.com>
In-Reply-To: <m1y8vufe5l.fsf@ebiederm.dsl.xmission.com>
References: <20031008172235.70d6b794.rddunlap@osdl.org>
	 <Pine.NEB.4.58.0310090401310.17767@sdf.lonestar.org>
	 <m1y8vufe5l.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Organization: 
Message-Id: <1065734288.1658.35.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 09 Oct 2003 15:18:08 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-10-09 at 12:40, Eric W. Biederman wrote:
> Cherry George Mathew <cherry@sdf.lonestar.org> writes:
> 
> > On Wed, 8 Oct 2003, Randy.Dunlap wrote:
> > 
> > > You'll need to update the kexec-syscall.c file for the correct
> > > kexec syscall number (274).
> > 
> > Is there a consensus about what the syscall number will finally be ? We've
> > jumped from 256 to 274 over the 2.5.x+  series kernels. Or is it the law
> > the Jungle ?
> 
> So far the law of the jungle.  Regardless of the rest it looks like it
> is time to submit a place keeping patch.
> 
> Eric
> -

And if Linus takes that patch, Hans should do the same for __NR_reiser4
for the same reason.

Steven

