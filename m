Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264723AbSKDQLX>; Mon, 4 Nov 2002 11:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264724AbSKDQLX>; Mon, 4 Nov 2002 11:11:23 -0500
Received: from otter.mbay.net ([206.55.237.2]:5130 "EHLO otter.mbay.net")
	by vger.kernel.org with ESMTP id <S264723AbSKDQLV> convert rfc822-to-8bit;
	Mon, 4 Nov 2002 11:11:21 -0500
From: John Alvord <jalvo@mbay.net>
To: "Richard J Moore" <richardj_moore@uk.ibm.com>
Cc: Oliver Xymoron <oxymoron@waste.org>, Dave Anderson <anderson@redhat.com>,
       linux-kernel@vger.kernel.org, lkcd-devel@lists.sourceforge.net,
       lkcd-general@lists.sourceforge.net,
       lkcd-general-admin@lists.sourceforge.net,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linus Torvalds <torvalds@transmeta.com>,
       "Matt D. Robinson" <yakker@aparity.com>
Subject: Re: [lkcd-general] Re: What's left over.
Date: Mon, 04 Nov 2002 08:16:04 -0800
Message-ID: <c17dsugl3gqditkhdqka4hojqtfcj0u0g6@4ax.com>
References: <OFE5D1360D.AD5C65BE-ON80256C67.004027FF@portsmouth.uk.ibm.com>
In-Reply-To: <OFE5D1360D.AD5C65BE-ON80256C67.004027FF@portsmouth.uk.ibm.com>
X-Mailer: Forte Agent 1.92/32.570
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Nov 2002 11:59:23 +0000, "Richard J Moore"
<richardj_moore@uk.ibm.com> wrote:

>
>
>> What he really wants is for Andrew or Alan or someone else he trusts
>> to merge it, get actual field results, and declare it useful. If
>> people start visibly passing around crash dump results on l-k and
>> solving problems with them, that'll help too. Until then all he has is
>> his gut feel to go on.
>
>Are you sure? Isn't what Linus is saying is that he understands that some
>problems can be solved using dumps, some from the oops message and some by
>source code inspection and some by others means. But, he's not interested
>in a timely resolution; he has a preference for solving the problems by
>looking at the source and only that way. That's his preference: arguments
>relating to timeliness and commercial considerations are of no interest to
>him - simply because they argue for benefits in which he has no interest.
>Because LKCD doesn't personally interest him he has declared that he will
>not merge it; it' up to some trusted advocate.

What you describe is certainly Linus' general philosophy.

But he also said that the feature was in "vendor push" mode, which
means if enough vendors adopt the feature he would consider. Why do
you think reisferfs got into the mainline - certainly not because he
uses it personally.

He also said he has seen no evidence of its usefulness... not one
report on L-K of kernel problems resolved.

Seems pretty clear to me...

john alvord
