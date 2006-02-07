Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965155AbWBGPQF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965155AbWBGPQF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 10:16:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965160AbWBGPQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 10:16:05 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:12429 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S965155AbWBGPQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 10:16:02 -0500
To: Rik van Riel <riel@redhat.com>
Cc: Kirill Korotaev <dev@sw.ru>, Kirill Korotaev <dev@openvz.org>,
       Linus Torvalds <torvalds@osdl.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, frankeh@watson.ibm.com, clg@fr.ibm.com,
       haveblue@us.ibm.com, greg@kroah.com, alan@lxorguk.ukuu.org.uk,
       serue@us.ibm.com, arjan@infradead.org, kuznet@ms2.inr.ac.ru,
       saw@sawoct.com, devel@openvz.org, Dmitry Mishin <dim@sw.ru>,
       Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 1/4] Virtualization/containers: introduction
References: <43E7C65F.3050609@openvz.org>
	<m1bqxju9iu.fsf@ebiederm.dsl.xmission.com> <43E88F27.7050602@sw.ru>
	<m1ek2fgt51.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.63.0602070951380.18234@cuia.boston.redhat.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 07 Feb 2006 08:13:28 -0700
In-Reply-To: <Pine.LNX.4.63.0602070951380.18234@cuia.boston.redhat.com> (Rik
 van Riel's message of "Tue, 7 Feb 2006 09:52:17 -0500 (EST)")
Message-ID: <m1wtg7fbhj.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@redhat.com> writes:

> On Tue, 7 Feb 2006, Eric W. Biederman wrote:
>
>> Yes people have to be willing to bend to work together to find the
>> best solution. I am willing.  At the same time I am not easy to
>> convince that other solutions are necessarily better.
>
> It's not about "better", it's about different requirements.

In part but I think it is possible to largely agree on what the requirements
for the kernel are, by seeing what the requirements of the different
users are.  That is part of the discussion.

Once those requirements are agreed upon it is about the best technical
solution.

Maintainability is one of the more important requirements is it not?

Eric
