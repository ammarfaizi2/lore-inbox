Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932266AbWBKNnS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266AbWBKNnS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 08:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbWBKNnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 08:43:18 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:37062 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932266AbWBKNnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 08:43:17 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>, nigel@suspend2.net, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [ 00/10] [Suspend2] Modules support.
References: <20060201113710.6320.68289.stgit@localhost.localdomain>
	<200602022131.59928.nigel@suspend2.net>
	<20060202115907.GH1884@elf.ucw.cz>
	<200602022214.52752.nigel@suspend2.net> <20060202152316.GC8944@ucw.cz>
	<20060202132708.62881af6.akpm@osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sat, 11 Feb 2006 06:42:12 -0700
In-Reply-To: <20060202132708.62881af6.akpm@osdl.org> (Andrew Morton's
 message of "Thu, 2 Feb 2006 13:27:08 -0800")
Message-ID: <m1wtg23tcb.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> - If you want my cheerfully uninformed opinion, we should toss both of
>   them out and implement suspend3, which is based on the kexec/kdump
>   infrastructnure.  There's so much duplication of intent here that it's not
>   funny.  And having them separate like this weakens both in the area where
>   the real problems are: drivers.

Ahh!!! I'm surrounded.

suspend by kexec
suspend by migration

Is there a way out?

Can I avoid it?

Do all roads lead to suspend?

:)

Eric
