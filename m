Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751806AbWHATKz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751806AbWHATKz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 15:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751811AbWHATKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 15:10:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:61637 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751806AbWHATKy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 15:10:54 -0400
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: <linux-kernel@vger.kernel.org>, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       Vivek Goyal <vgoyal@in.ibm.com>, Linda Wang <lwang@redhat.com>
Subject: Re: [PATCH 26/33] x86_64: 64bit PIC ACPI wakeup
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
	<1154430244487-git-send-email-ebiederm@xmission.com>
From: Andi Kleen <ak@suse.de>
Date: 01 Aug 2006 21:10:48 +0200
In-Reply-To: <1154430244487-git-send-email-ebiederm@xmission.com>
Message-ID: <p73hd0w1dc7.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric W. Biederman" <ebiederm@xmission.com> writes:
> 
> I don't have a configuration I can test this but it compiles cleanly
> and it should work, the code is very similar to the SMP trampoline,
> which I have tested.  At least now the comments about still running in
> low memory are actually correct.

We would need someone to actually test this before it could 
be merged. I didn't see anything that tripped me up though.

-Andi
