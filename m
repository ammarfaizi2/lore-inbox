Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752080AbWCBXTo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752080AbWCBXTo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 18:19:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752083AbWCBXTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 18:19:43 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:2962 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1752081AbWCBXTn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 18:19:43 -0500
To: Sam Vilain <sam@vilain.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] proc: Use sane permission checks on the /proc/<pid>/fd/
 symlinks.
References: <440765E2.6000209@vilain.net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 02 Mar 2006 16:18:14 -0700
In-Reply-To: <440765E2.6000209@vilain.net> (Sam Vilain's message of "Fri, 03
 Mar 2006 10:38:42 +1300")
Message-ID: <m1bqwoigg9.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Vilain <sam@vilain.net> writes:


> Nice solution to this problem we were discussion, Eric!  I agree with the ptrace
> analogy and support it in the context of Linux-VServer.

Thanks.

I'm getting there one small step at a time.

Eric
