Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263828AbUEMGlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263828AbUEMGlL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 02:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263776AbUEMGlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 02:41:11 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:47025 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S263828AbUEMGk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 02:40:58 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: hch@infradead.org, rddunlap@osdl.org, davidm@hpl.hp.com,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org,
       drepper@redhat.com
Subject: Re: [Fastboot] Re: [announce] kexec for linux 2.6.6
References: <m13c66qicb.fsf@ebiederm.dsl.xmission.com>
	<40A243C8.401@redhat.com> <m1brktod3f.fsf@ebiederm.dsl.xmission.com>
	<40A2517C.4040903@redhat.com>
	<m17jvhoa6g.fsf@ebiederm.dsl.xmission.com>
	<20040512143233.0ee0405a.rddunlap@osdl.org>
	<16546.41076.572371.307153@napali.hpl.hp.com>
	<20040512152815.76280eac.akpm@osdl.org>
	<16546.42537.765495.231960@napali.hpl.hp.com>
	<20040512161603.44c50cec.akpm@osdl.org>
	<20040513053051.A5286@infradead.org>
	<m1lljwsvxr.fsf@ebiederm.dsl.xmission.com>
	<20040512232009.6b241152.akpm@osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 13 May 2004 00:39:05 -0600
In-Reply-To: <20040512232009.6b241152.akpm@osdl.org>
Message-ID: <m1brksesqe.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> ebiederm@xmission.com (Eric W. Biederman) wrote:
> >
> > So if kexec could actually get a reserved system call number that
> >  would be the best solution I have seen in this thread.
> 
> I have no problem with that - it's a major feature, vendors will, I assume,
> ship it so it's worth blowing the four bytes to pin the ABI down for
> everyone.
> 
> >  Andrew how close are we to a point where we can look at kexec inclusion?
> 
> Well it's not exactly head-of-queue.  Do any vendors actually intend to
> ship it?

I know of a few products kexec is embedded in already.  As for the
general purpose distro's I don't know.

Eric
