Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965151AbWBGQTp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965151AbWBGQTp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 11:19:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965157AbWBGQTp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 11:19:45 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:59277 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S965151AbWBGQTo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 11:19:44 -0500
To: linux@horizon.com
Cc: davidchow@shaolinmicro.com, linux-kernel@vger.kernel.org
Subject: Re: Linux drivers management
References: <20060207044204.8908.qmail@science.horizon.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 07 Feb 2006 09:18:55 -0700
In-Reply-To: <20060207044204.8908.qmail@science.horizon.com> (linux@horizon.com's
 message of "6 Feb 2006 23:42:04 -0500")
Message-ID: <m1zml3rvkg.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux@horizon.com writes:

> The Linux developers are quite opposed to that, for a variety of excellent
> reasons I won't bother enumerating.  Linus has said he'll (grudgingly)
> allow it, but won't lift a finger to help.  Linux development sailed
> away from the idea of a stable binary interface years ago, and isn't
> looking back.

Almost true.  There is a stable binary interface to user space,
and work is done to maintain that interface.

I just thought I would mention it because too frequently people
get the policy on the in-kernel api and the ABI to user space
confused.

In general the user space ABI is only appended to.

Eric
