Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263860AbUEMHdO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263860AbUEMHdO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 03:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263875AbUEMHdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 03:33:14 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:50959 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263860AbUEMHdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 03:33:11 -0400
Date: Thu, 13 May 2004 08:33:06 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, rddunlap@osdl.org, davidm@hpl.hp.com,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org,
       drepper@redhat.com
Subject: Re: [Fastboot] Re: [announce] kexec for linux 2.6.6
Message-ID: <20040513083306.A6631@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Andrew Morton <akpm@osdl.org>, rddunlap@osdl.org, davidm@hpl.hp.com,
	fastboot@lists.osdl.org, linux-kernel@vger.kernel.org,
	drepper@redhat.com
References: <m1brktod3f.fsf@ebiederm.dsl.xmission.com> <40A2517C.4040903@redhat.com> <m17jvhoa6g.fsf@ebiederm.dsl.xmission.com> <20040512143233.0ee0405a.rddunlap@osdl.org> <16546.41076.572371.307153@napali.hpl.hp.com> <20040512152815.76280eac.akpm@osdl.org> <16546.42537.765495.231960@napali.hpl.hp.com> <20040512161603.44c50cec.akpm@osdl.org> <20040513053051.A5286@infradead.org> <m1lljwsvxr.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m1lljwsvxr.fsf@ebiederm.dsl.xmission.com>; from ebiederm@xmission.com on Thu, May 13, 2004 at 12:06:08AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2004 at 12:06:08AM -0600, Eric W. Biederman wrote:
> So if kexec could actually get a reserved system call number that
> would be the best solution I have seen in this thread.

Could you please show the syscall we should reserve, e.g. it's API.
We had quite some histroy of syscalls that got reserved and the real
submission was rejected neverless because the API was broken.

