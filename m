Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268496AbUHQWmS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268496AbUHQWmS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 18:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268494AbUHQWlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 18:41:52 -0400
Received: from fw.osdl.org ([65.172.181.6]:2229 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268489AbUHQWlD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 18:41:03 -0400
Date: Tue, 17 Aug 2004 15:44:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: hari@in.ibm.com
Cc: linux-kernel@vger.kernel.org, fastboot@osdl.org, suparna@in.ibm.com,
       mbligh@aracnet.com, litke@us.ibm.com, ebiederm@xmission.com
Subject: Re: [RFC]Kexec based crash dumping
Message-Id: <20040817154436.529ba9f6.akpm@osdl.org>
In-Reply-To: <20040817120239.GA3916@in.ibm.com>
References: <20040817120239.GA3916@in.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hariprasad Nellitheertha <hari@in.ibm.com> wrote:
>
> The patches that follow contain the initial implementation for kexec based
> crash dumping that we are working on.

It seems to be coming together nicely.

Where do we stand with support for other architectures?  Do you expect that
each architecture will involve a lot of work?

And how much of the i386 implementation do you expect x86_64 can
reuse?
