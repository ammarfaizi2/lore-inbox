Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264093AbTKMNGX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 08:06:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264119AbTKMNGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 08:06:22 -0500
Received: from dsl092-073-159.bos1.dsl.speakeasy.net ([66.92.73.159]:12295
	"EHLO yupa.krose.org") by vger.kernel.org with ESMTP
	id S264093AbTKMNGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 08:06:21 -0500
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Paging request oops in 2.6.0-test9-bk16
X-Home-Page: http://www.krose.org/~krose/
References: <87islohptz.fsf@nausicaa.krose.org>
	<shsr80cer6p.fsf@charged.uio.no>
From: Kyle Rose <krose+linux-kernel@krose.org>
Organization: krose.org
Content-Type: text/plain; charset=US-ASCII
Date: Thu, 13 Nov 2003 08:06:15 -0500
In-Reply-To: <shsr80cer6p.fsf@charged.uio.no> (Trond Myklebust's message of
 "13 Nov 2003 01:08:30 -0500")
Message-ID: <87ekwch0zc.fsf@nausicaa.krose.org>
User-Agent: Gnus/5.090024 (Oort Gnus v0.24) XEmacs/21.4 (Reasonable
 Discussion, linux)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> writes:

>>>>>> " " == Kyle Rose <krose@krose.org> writes:
>
>      > Got an oops tonight when trying to access an NFS mounted
>      > partition through SFS (www.fs.net):
>
> Can it be duplicated against a normal NFS server?

I haven't tried: I'll set one up and do some stress testing.

> Why is your kernel labelled as "tainted"? Are you loading any modules
> other than the ones listed in you .config?

Yep, nvidia driver.

Cheers,
Kyle
