Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268360AbUJVXE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268360AbUJVXE3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 19:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268301AbUJVW6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 18:58:52 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:25815 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268330AbUJVW62 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 18:58:28 -0400
Subject: Re: My thoughts on the "new development model"
From: Lee Revell <rlrevell@joe-job.com>
To: Espen =?ISO-8859-1?Q?Fjellv=E6r?= Olsen <espenfjo@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <7aaed09104102214521e90c27c@mail.gmail.com>
References: <7aaed09104102213032c0d7415@mail.gmail.com>
	 <7aaed09104102214521e90c27c@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: Fri, 22 Oct 2004 18:58:24 -0400
Message-Id: <1098485905.1440.11.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-22 at 23:52 +0200, Espen Fjellvær Olsen wrote:
> I think that 2.6 should be frozen from now on, just security related
> stuff should be merged.
> This would strengthen Linux's reputation as a stable and secure
> system, not a unstable and a system just used for fun.

My $0.02:

Part of the reasoning behind the new development model is that if you
want a stable kernel, there are many vendors who will give you one.  The
new dev model is partially driven by vendors and developers desire to
get their features into mainline quicker.  There is an inherent
stability cost associated with this, but the price is only paid by users
who want stability AND the latest kernel.org kernel.  The big players
all seem to agree that the new development model better suits users and
their own needs.  The distros are in a better position to determine what
constitutes a stable kernel anyway, they have millions of users to test
on.  Let the vendors AND the kernel hackers do what they are each best
at.

We need to continue the rapid pace of development because although Linux
rules in the small to mid server arena there are other areas where MS
and Apple are clearly ahead.  If you want to make an omelette you have
to break some eggs...

Lee

