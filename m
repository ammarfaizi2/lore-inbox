Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263425AbUDMODq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 10:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263558AbUDMODq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 10:03:46 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:34971 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S263425AbUDMODo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 10:03:44 -0400
To: rpc@cafe4111.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: Rewrite Kernel
References: <20040407125406.209FC39834A@ws5-1.us4.outblaze.com>
	<200404071057.23427.rpc@cafe4111.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 13 Apr 2004 08:03:26 -0600
In-Reply-To: <200404071057.23427.rpc@cafe4111.org>
Message-ID: <m1d66cj7pt.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Couto <rpc@cafe4111.org> writes:

> On Wednesday 07 April 2004 08:54 am, you wrote:
> > i wanna to rewrite a version of linux kernel from scratch in assembly for
> > intel 386+ fo speed and a libc also in assembly for speed what do u think
> > guys
> 
> maybe you'd have fun with the LinuxBIOS crowd
> www.linuxbios.org

Likely just the opposite.  We have written a C compiler that does not
implicitly use memory.  Having had to reinvent the wheel a feel times
because of where we are working, it is clear that tools are your friend.

There is no shame in rewriting something when what exists does not work
for you and it matters.  If your rewrite happens to be significantly faster
than the broken version that is just a plus. :)

Eric

