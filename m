Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263041AbUEOCbI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263041AbUEOCbI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 22:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264391AbUEOCbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 22:31:08 -0400
Received: from zeus.kernel.org ([204.152.189.113]:7404 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S263041AbUEOCbF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 22:31:05 -0400
To: Adam Litke <agl@us.ibm.com>
Cc: akpm <akpm@osdl.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       fastboot@lists.osdl.org, drepper@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] Re: [announce] kexec for linux 2.6.6
References: <20040511212625.28ac33ef.rddunlap@osdl.org>
	<40A1AF53.3010407@redhat.com>
	<m13c66qicb.fsf@ebiederm.dsl.xmission.com> <40A243C8.401@redhat.com>
	<m1brktod3f.fsf@ebiederm.dsl.xmission.com>
	<40A2517C.4040903@redhat.com>
	<m17jvhoa6g.fsf@ebiederm.dsl.xmission.com>
	<20040512143233.0ee0405a.rddunlap@osdl.org>
	<m1wu3fy46w.fsf@ebiederm.dsl.xmission.com>
	<1084558463.9305.33.camel@agtpad>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 14 May 2004 20:25:49 -0600
In-Reply-To: <1084558463.9305.33.camel@agtpad>
Message-ID: <m11xlmxw7m.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Litke <agl@us.ibm.com> writes:

> On Thu, 2004-05-13 at 22:21, Eric W. Biederman wrote:
> > Also been work on x86-64 and ppc32.   So if we are going to reserve
> > syscall numbers  it would also be nice to have those reserved as well.
> 
> Don't forget about ppc64.

Randy already mentioned it.  :)
Making the list of at least attempted ports:

x86, ppc64, ia64, x86-64, ppc32

But x86 and ppc64 seem to have the most developer interest.

Eric
