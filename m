Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932177AbWHHLzf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbWHHLzf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 07:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932470AbWHHLzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 07:55:35 -0400
Received: from jaguar.mkp.net ([192.139.46.146]:43185 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S932177AbWHHLze (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 07:55:34 -0400
To: "Alexey Zaytsev" <alexey.zaytsev@gmail.com>
Cc: "Andi Kleen" <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Time to forbid non-subscribers from posting to the list?
References: <f19298770608080407n5788faa8x779ad84fe53726cb@mail.gmail.com>
	<p73y7tzo4hl.fsf@verdi.suse.de>
	<f19298770608080447l3e31465fqb6fbc8cfed71cb80@mail.gmail.com>
From: Jes Sorensen <jes@sgi.com>
Date: 08 Aug 2006 07:55:33 -0400
In-Reply-To: <f19298770608080447l3e31465fqb6fbc8cfed71cb80@mail.gmail.com>
Message-ID: <yq03bc7v3uy.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Alexey" == Alexey Zaytsev <alexey.zaytsev@gmail.com> writes:

Alexey> On 08 Aug 2006 13:23:50 +0200, Andi Kleen <ak@suse.de> wrote:
>> You would make bug reports impossible from normal people who don't
>> want to subscribe fully. It would totally wreck the development
>> model.
Alexey> If they don't want to subscribe, they can just report to the
Alexey> list as usual, theyr mail will be only slightly delayed
Alexey> because of moderation.  We could even use some sort of white
Alexey> lists, if a user's mail was once approved, all his further
Alexey> mail will be accepthed without moderation.

At 400-500 mails per day, who is going to handle the moderation? Sure
only a portion would be held back, but there's plenty other work to do
and we want fast turnaround for user bug reports, so if a user is
asked a question he/she can respond quickly with more details.

Moderation is a bad idea, right up there with C++ kernel modules, and
splitting the source code into smaller tarballs. For some reason they
all seem to get proposed again and again on a semi regular basis. If
people would just read the archives.....

Just install a proper spam filter like everyone else.

Jes
