Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750885AbWKBGmJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbWKBGmJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 01:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751067AbWKBGmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 01:42:09 -0500
Received: from smtp.osdl.org ([65.172.181.4]:54660 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750885AbWKBGmG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 01:42:06 -0500
Date: Wed, 1 Nov 2006 22:41:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@google.com>
Cc: Greg KH <gregkh@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>,
       Mike Galbraith <efault@gmx.de>, Andy Whitcroft <apw@shadowen.org>,
       linux-kernel@vger.kernel.org, Steve Fox <drfickle@us.ibm.com>
Subject: Re: 2.6.19-rc3-mm1 -- missing network adaptors
Message-Id: <20061101224128.25c714e4.akpm@osdl.org>
In-Reply-To: <454990F7.8040408@google.com>
References: <20061031075825.GA8913@suse.de>
	<45477131.4070501@google.com>
	<20061031174639.4d4d20e3@gondolin.boeblingen.de.ibm.com>
	<4547833C.5040302@google.com>
	<20061031182919.3a15b25a@gondolin.boeblingen.de.ibm.com>
	<4547FABE.502@google.com>
	<20061101020850.GA13070@suse.de>
	<45480241.2090803@google.com>
	<20061102052409.GA9642@suse.de>
	<45498174.5070309@google.com>
	<20061102060225.GA11188@suse.de>
	<454990F7.8040408@google.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Nov 2006 22:32:23 -0800
"Martin J. Bligh" <mbligh@google.com> wrote:

> > Oops, the newest -mm just came out without any of the driver core
> > patches in it due to the problems.  I'll wait until the next -mm release
> > then, and try to go catch up on my pending-patch-queue right now
> > instead...
> 
> If we can test it out of sync, it'd save potentially messing up another
> -mm cycle. The problem is that it blocks lots of other patches from
> getting tested ...

is OK - I wasn't doing anything useful anyway.
