Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262379AbTJISld (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 14:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262395AbTJISld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 14:41:33 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:36414 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262379AbTJISlc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 14:41:32 -0400
To: Cherry George Mathew <cherry@sdf.lonestar.org>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, fastboot@osdl.org,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Fastboot] kexec update (2.6.0-test7)
References: <20031008172235.70d6b794.rddunlap@osdl.org>
	<Pine.NEB.4.58.0310090401310.17767@sdf.lonestar.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 09 Oct 2003 12:40:22 -0600
In-Reply-To: <Pine.NEB.4.58.0310090401310.17767@sdf.lonestar.org>
Message-ID: <m1y8vufe5l.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cherry George Mathew <cherry@sdf.lonestar.org> writes:

> On Wed, 8 Oct 2003, Randy.Dunlap wrote:
> 
> > You'll need to update the kexec-syscall.c file for the correct
> > kexec syscall number (274).
> 
> Is there a consensus about what the syscall number will finally be ? We've
> jumped from 256 to 274 over the 2.5.x+  series kernels. Or is it the law
> the Jungle ?

So far the law of the jungle.  Regardless of the rest it looks like it
is time to submit a place keeping patch.

Eric
