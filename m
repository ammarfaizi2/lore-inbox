Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261972AbVGEWnx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261972AbVGEWnx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 18:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261975AbVGEWnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 18:43:53 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.83]:29914 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S261972AbVGEWnh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 18:43:37 -0400
From: Jeremy Maitin-Shepard <jbms@cmu.edu>
To: ninja@slaphack.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: reiser4 plugins
References: <200507042032.j64KWiY9009684@laptop11.inf.utfsm.cl>
	<42CB0A40.3070903@slaphack.com>
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-1: winter into spring
Date: Tue, 05 Jul 2005 18:43:31 -0400
In-Reply-To: <42CB0A40.3070903@slaphack.com> (David Masover's message of "Tue,
	05 Jul 2005 17:31:28 -0500")
Message-ID: <877jg4an70.fsf@jbms.ath.cx>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Masover <ninja@slaphack.com> writes:

[snip]

>> I have. And have seen /no/ benefit to you. Except, of course, the benefit
>> accrued from some magic in Linus' kernel, by which all format differences
>> go in a puff of smoke if they are implemented inside it, and furthermore
>> all userland gets rebuilt to use the kernel's way overnight.

> Let's say cryptocompress gets implemented.  Not all of userland
> rewritten, not even any of userland rewritten, just a cryptocompress
> plugin for the kernel.  And instead of having to learn a new tool, I can
> just browse around in /meta.

What is the relationship between file-as-dir or special meta-data and
transparent encryption+compression?  I do not see why file-as-dir would
require such a special interface.

[snip]

-- 
Jeremy Maitin-Shepard
