Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbWIYOML@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbWIYOML (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 10:12:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbWIYOMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 10:12:10 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:32184 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S932148AbWIYOMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 10:12:09 -0400
Subject: Re: GPLv3 Position Statement
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Michiel de Boer <x@rebelhomicide.demon.nl>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <451798FA.8000004@rebelhomicide.demon.nl>
References: <1158941750.3445.31.camel@mulgrave.il.steeleye.com>
	 <451798FA.8000004@rebelhomicide.demon.nl>
Content-Type: text/plain
Date: Mon, 25 Sep 2006 09:12:03 -0500
Message-Id: <1159193523.3463.14.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-09-25 at 10:53 +0200, Michiel de Boer wrote:
> For what it's worth, i support RMS and his fight for free software fully.
> I support the current draft of the GPL version 3 and am very dissapointed
> it will not be adopted as is. IMHO, Linux has the power and influence
> to move mountains in the software industry, and shouldn't shy away from
> the opportunity to take moral responsibility when it arises.

Well ... as Russell already pointed out; adopting GPLv3 was made
incredibly difficult for us by the FSF.  We could easily adopt a GPLv2
compatible licence simply by going through some sort of process to
secure agreement and then altering the COPYING file of the kernel (the
point being that past contributions would still be v2, future
contributions would be the new licence and there's no distribution
problem because they're compatible).

There are definite bug fixes to v2 in the v3 draft:  Bittorrent and
termination.  However, we could adopt those in a v2 compatible fashion
(as additional permissions).  Additionally, it does strike me that a
patent grant could be formulated in a v2 compatible manner if people
agreed on it.  Obviously, the additional restrictions of v3 is
completely impossible to accommodate in a v2 compatible manner.  The DRM
provisions could be disputed: if you believe they're already in v2, then
they could be adopted in a v2 compatible fashion as a clarification ...
however, they'd have to be quite a bit less broad than the current v3
language.

All in all, we could probably only switch to v3 by some type of
universal acclamation process, which, with 28 votes against already
isn't really likely.

James


