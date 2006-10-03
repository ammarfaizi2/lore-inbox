Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030222AbWJCBYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030222AbWJCBYI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 21:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030221AbWJCBYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 21:24:07 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:59087 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030222AbWJCBYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 21:24:06 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: rdreier@cisco.com, linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 0 of 28] ipath patches for 2.6.19
References: <patchbomb.1159459196@eng-12.pathscale.com>
	<m1irj6gph2.fsf@ebiederm.dsl.xmission.com>
	<452156F4.4050004@pathscale.com>
Date: Mon, 02 Oct 2006 19:22:31 -0600
In-Reply-To: <452156F4.4050004@pathscale.com> (Bryan O'Sullivan's message of
	"Mon, 02 Oct 2006 11:14:12 -0700")
Message-ID: <m1zmce6vmw.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Bryan O'Sullivan" <bos@pathscale.com> writes:

> Eric W. Biederman wrote:
>
>> Have you tested your driver against the -mm tree?
>
> No.
>
>> To the best of my knowledge the irq handling of your hypertransport card
>> is a complete and total hack that works only by chance.
>
> And a happy Monday morning to you, too :-)
:)

>> In the -mm tree I have added a first pass at proper support for the
>> hypertranport interrupt capability.  As this code is slated to go into
>> 2.6.19 could you please test against that?
>
> I'm on vacation for a few weeks.  We'll find someone to do it.

Sure.  I talked to Dave Olson about this a while ago, and I couldn't
get anything happening.

Eric


