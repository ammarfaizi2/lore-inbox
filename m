Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264278AbUHTIUk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264278AbUHTIUk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 04:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267827AbUHTIUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 04:20:39 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:40352 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S264278AbUHTISz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 04:18:55 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: hari@in.ibm.com, suparna@in.ibm.com, fastboot@osdl.org, litke@us.ibm.com,
       linux-kernel@vger.kernel.org, mbligh@aracnet.com
Subject: Re: [Fastboot] Re: [RFC]Kexec based crash dumping
References: <20040817120239.GA3916@in.ibm.com>
	<20040817154436.529ba9f6.akpm@osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 20 Aug 2004 02:17:35 -0600
In-Reply-To: <20040817154436.529ba9f6.akpm@osdl.org>
Message-ID: <m1isbe8bq8.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> Hariprasad Nellitheertha <hari@in.ibm.com> wrote:
> >
> > The patches that follow contain the initial implementation for kexec based
> > crash dumping that we are working on.
> 
> It seems to be coming together nicely.

Well it is coming.  There is a lot of exploratory work still needed to
find what it takes to reliably get a kernel working in the hostile
environment present after a kernel panic.  That really has 
barely begun and it likely to turn up some unexpected architecture
specific issues.

Eric
