Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266344AbUA2UfV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 15:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266346AbUA2UfV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 15:35:21 -0500
Received: from main.gmane.org ([80.91.224.249]:61127 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S266344AbUA2UfI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 15:35:08 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: Lindent fixed to match reality
Date: Thu, 29 Jan 2004 21:35:03 +0100
Message-ID: <yw1xr7xi1ojs.fsf@kth.se>
References: <20040129193727.GJ21888@waste.org> <20040129201556.GK16675@khan.acc.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
Gmane-NNTP-Posting-Host: ti200710a080-2939.bb.online.no
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:pD/09aph6WdyXKg9VhYjO7+15Qw=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Weinehall <tao@acc.umu.se> writes:

>> b) (no -bs) "sizeof(foo)" rather than "sizeof (foo)"
>
> I can't really see the logic in this, though I know a lot of people do
> it.  I try to stay consistent, thus I do:
>
> if ()
> for ()
> case ()
> while ()
> sizeof ()
> typeof ()
>
> since they're all parts of the language, rather than
> functions/macros or invocations of such.

What I fail to see here is why that should make a difference regarding
whitespace before the parens.

-- 
Måns Rullgård
mru@kth.se

