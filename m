Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261820AbVASSTK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261820AbVASSTK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 13:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbVASSTK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 13:19:10 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:4289 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261820AbVASSTF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 13:19:05 -0500
To: Hariprasad Nellitheertha <hari@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] Re: [PATCH 16/29] x86-kexec
References: <overview-11061198973484@ebiederm.dsl.xmission.com>
	<x86-64-e820-64bit-11061198971581@ebiederm.dsl.xmission.com>
	<x86-i8259-shutdown-11061198973856@ebiederm.dsl.xmission.com>
	<x86-64-i8259-shutdown-11061198973969@ebiederm.dsl.xmission.com>
	<x86-apic-virtwire-on-shutdown-11061198973730@ebiederm.dsl.xmission.com>
	<x86-64-apic-virtwire-on-shutdown-11061198973345@ebiederm.dsl.xmission.com>
	<vmlinux-fix-physical-addrs-11061198973860@ebiederm.dsl.xmission.com>
	<x86-vmlinux-fix-physical-addrs-11061198971192@ebiederm.dsl.xmission.com>
	<x86-64-vmlinux-fix-physical-addrs-11061198972723@ebiederm.dsl.xmission.com>
	<x86-64-entry64-1106119897218@ebiederm.dsl.xmission.com>
	<x86-config-kernel-start-1106119897152@ebiederm.dsl.xmission.com>
	<x86-64-config-kernel-start-11061198972987@ebiederm.dsl.xmission.com>
	<kexec-kexec-generic-11061198974111@ebiederm.dsl.xmission.com>
	<x86-machine-shutdown-1106119897775@ebiederm.dsl.xmission.com>
	<x86-kexec-11061198971773@ebiederm.dsl.xmission.! com>
	<41EE4E30.6060908@in.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 19 Jan 2005 11:17:23 -0700
In-Reply-To: <41EE4E30.6060908@in.ibm.com>
Message-ID: <m1pt015ln0.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hariprasad Nellitheertha <hari@in.ibm.com> writes:

> Hello Eric,
> 
> Eric W. Biederman wrote:
> > This is the i386 implementation of kexec.
> 
> I tried these patches on an i386 box with kexec-tools-1.99. kexec-ing with
> vmlinux works fine but bzImage still doesnt go through. Is there a newer
> kexec-tools package that we need to use this with (to take care of the
> "purgatory code getting overwritten" problem you had identified).

Yes.  I will release the 2.0 version shortly.  I need to give it a code
review before I put it out.  So sometime later today.

Eric
