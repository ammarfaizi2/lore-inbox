Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266648AbUJPT1n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266648AbUJPT1n (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 15:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266680AbUJPT1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 15:27:43 -0400
Received: from peabody.ximian.com ([130.57.169.10]:22193 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S266648AbUJPT1T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 15:27:19 -0400
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U4
From: Robert Love <rml@novell.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Adam Heath <doogie@debian.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20041016192402.GA10445@elte.hu>
References: <20041012091501.GA18562@elte.hu> <20041012123318.GA2102@elte.hu>
	 <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu>
	 <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu>
	 <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu>
	 <20041016153344.GA16766@elte.hu>
	 <Pine.LNX.4.58.0410161353530.1219@gradall.private.brainfood.com>
	 <20041016192402.GA10445@elte.hu>
Content-Type: text/plain
Date: Sat, 16 Oct 2004 15:27:40 -0400
Message-Id: <1097954860.5497.35.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-16 at 21:24 +0200, Ingo Molnar wrote:

> i changed my mind because lowercase it looks pretty ugly in uname,
> appended to the already lowercase -mm string. Why does Debian need to
> have it in lowercase anyway? It doesnt seem to make much sense.

It becomes part of the package version, and the package versions are
lowercase.  But I agree, it doesn't make much sense.

-RT does look better.

	Robert Love


