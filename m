Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262584AbVBYCFg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262584AbVBYCFg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 21:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262597AbVBYCFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 21:05:34 -0500
Received: from gw.goop.org ([64.81.55.164]:31433 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S262584AbVBYCFa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 21:05:30 -0500
Message-ID: <421E87E7.4080601@goop.org>
Date: Thu, 24 Feb 2005 18:05:27 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Mozilla Thunderbird  (X11/20041216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
Cc: Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] set RLIMIT_SIGPENDING limit based on RLIMIT_NPROC
References: <421D0D3F.40902@goop.org> <200502240224.j1O2OqHL010736@magilla.sf.frob.com> <20050224030747.GG15867@shell0.pdx.osdl.net>
In-Reply-To: <20050224030747.GG15867@shell0.pdx.osdl.net>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:

>It's an rlimit, so easily setable in userspace at login session time.  I
>think we could raise it if people start complaining it's too low (hasn't
>seemed to be a problem yet).
>
Know any shells which support setting it?  Indeed, glibc doesn't seem to
know about it.

    J
