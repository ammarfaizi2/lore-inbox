Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262151AbUB2VlD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 16:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262152AbUB2VlD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 16:41:03 -0500
Received: from main.gmane.org ([80.91.224.249]:36279 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262151AbUB2Vkr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 16:40:47 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: [ANNOUNCE] linux-libc-headers 2.6.3.0
Date: Sun, 29 Feb 2004 22:33:19 +0100
Message-ID: <yw1xn0711sgw.fsf@kth.se>
References: <200402291942.45392.mmazur@kernel.pl> <200402292130.55743.mmazur@kernel.pl>
 <c1tk26$c1o$1@terminus.zytor.com> <200402292221.41977.mmazur@kernel.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ti211310a080-4136.bb.online.no
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:tKZP+LUdHn7bQVSckLAnNCcSFlA=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mariusz Mazur <mmazur@kernel.pl> writes:

> On Sunday 29 of February 2004 22:03, H. Peter Anvin wrote:
>> If so, we actually have a bit of an issue w.r.t. the potential
>> legality of these headers.  Technically they're incompatible with LGPL
>> and BSD-licensed libraries; I think we need some kind of official
>> declaration that compiling against them is permitted.
>
> /me knows nothing about legalities. So if you could explain exactly why, what 
> to do about it and how can that help... (and why there wasn't any problem 
> earlier, when people used headers from linux tarballs?)

Excuse my ignorance, but why can't the headers from the kernel still
be used.  They seem to be working fine here.

-- 
Måns Rullgård
mru@kth.se

