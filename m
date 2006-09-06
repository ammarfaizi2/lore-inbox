Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751551AbWIFUQN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751551AbWIFUQN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 16:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751556AbWIFUQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 16:16:13 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:8836 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751551AbWIFUQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 16:16:12 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       fastboot@osdl.org
Subject: Re: [PATCH] x86_64 kexec: Remove experimental mark of kexec
References: <m1veo1vtev.fsf@ebiederm.dsl.xmission.com>
	<m1k64hvsru.fsf@ebiederm.dsl.xmission.com>
	<200609062122.14971.ak@suse.de>
Date: Wed, 06 Sep 2006 14:15:15 -0600
In-Reply-To: <200609062122.14971.ak@suse.de> (Andi Kleen's message of "Wed, 6
	Sep 2006 21:22:14 +0200")
Message-ID: <m1pse8vjjg.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> On Wednesday 06 September 2006 18:55, Eric W. Biederman wrote:
>> 
>> kexec has been marked experimental for a year now and all
>> of the serious problems have been worked through.  So it
>> is time (if not past time) to remove the experimental mark.
>> 
>
> Hmm, I personally have some doubts it is really not experimental
> (not because of the kexec code itself, but because of all the other drivers
> that still break)

That is a reasonable viewpoint.  Although by that a lot more of the kernel
deserves to be marked experimental. 

On the perverse side of the sentiment taking off experimental may increase
our number of testers and get the bugs fixed faster :)

> But applied for now.

Thanks.

Eric
