Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263818AbUEMGWc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263818AbUEMGWc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 02:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263824AbUEMGWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 02:22:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:56552 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263845AbUEMGVQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 02:21:16 -0400
Date: Wed, 12 May 2004 23:20:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: hch@infradead.org, rddunlap@osdl.org, davidm@hpl.hp.com,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org,
       drepper@redhat.com
Subject: Re: [Fastboot] Re: [announce] kexec for linux 2.6.6
Message-Id: <20040512232009.6b241152.akpm@osdl.org>
In-Reply-To: <m1lljwsvxr.fsf@ebiederm.dsl.xmission.com>
References: <m13c66qicb.fsf@ebiederm.dsl.xmission.com>
	<40A243C8.401@redhat.com>
	<m1brktod3f.fsf@ebiederm.dsl.xmission.com>
	<40A2517C.4040903@redhat.com>
	<m17jvhoa6g.fsf@ebiederm.dsl.xmission.com>
	<20040512143233.0ee0405a.rddunlap@osdl.org>
	<16546.41076.572371.307153@napali.hpl.hp.com>
	<20040512152815.76280eac.akpm@osdl.org>
	<16546.42537.765495.231960@napali.hpl.hp.com>
	<20040512161603.44c50cec.akpm@osdl.org>
	<20040513053051.A5286@infradead.org>
	<m1lljwsvxr.fsf@ebiederm.dsl.xmission.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) wrote:
>
> So if kexec could actually get a reserved system call number that
>  would be the best solution I have seen in this thread.

I have no problem with that - it's a major feature, vendors will, I assume,
ship it so it's worth blowing the four bytes to pin the ABI down for
everyone.

>  Andrew how close are we to a point where we can look at kexec inclusion?

Well it's not exactly head-of-queue.  Do any vendors actually intend to
ship it?

