Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269534AbRGaXRR>; Tue, 31 Jul 2001 19:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269533AbRGaXRA>; Tue, 31 Jul 2001 19:17:00 -0400
Received: from imladris.infradead.org ([194.205.184.45]:39177 "EHLO
	infradead.org") by vger.kernel.org with ESMTP id <S269534AbRGaXQn>;
	Tue, 31 Jul 2001 19:16:43 -0400
Date: Wed, 1 Aug 2001 00:06:46 +0100 (BST)
From: Riley Williams <rhw@MemAlpha.CX>
X-X-Sender: <rhw@infradead.org>
To: Craig Milo Rogers <rogers@ISI.EDU>
cc: Matti Aarnio <matti.aarnio@zmailer.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: OT: Virii on vger.kernel.org lists 
In-Reply-To: <1661.996618791@ISI.EDU>
Message-ID: <Pine.LNX.4.33.0107312343080.31582-100000@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi Craig.

 >>> Better than that, simply strip all non-text MIME attachments, or
 >>> bounce the messages containing them.  End of story.

 >> Two problems with that:
 >>
 >> 1. Some virii are text attachments. Your fix doesn't deal with them.

 > I'm not aware of the TEXT/PLAIN viruses (ignoring jokes, er,
 > social comments, about the GPL). Could you point me to a sample?

Are you limiting "text attachments" to TEXT/PLAIN ??? If so, you just
killed a large number of very useful attachments. Off the top of my
head...

 1. Most patches that are attached rather than inline arrive here
    as TEXT/DIFF so you've just killed a lot of very important
    attachments.

 2. Some of Linus Torvalds' emails come with a TEXT/SIGNATURE
    attachment, so you've just prevented him posting from the
    computer that does that.

 3. One of the assignments at University was to email a specific
    MS-Word document (with an auto-starting macro in it) through a
    mailer that was specifically set to strip any attachments of the
    relevant mime types. In a class of 43 students, only two failed
    that assignment, and between the 41 who succeeded, no less than
    SEVEN different ways to do so were used, ALL of which used TEXT/
    mime types for the enclosure - and FIVE of those were new to the
    lecturer as well. The said lecturer also stated that there were
    a further NINE ways to do so that none of us had found, but did
    not go into detail.

Once you allow TEXT/* to pass, you discover just how many virii will
get straight past your filter without any problems at all. Basically,
you get nowhere doing that...

 >> 2. The maintainer of the XXX driver just uploaded a large patch that
 >>    fixes a major bug in their driver to the mailing list, and zip'd
 >>    it up to reduce its size. You just bounced it...

 > I recall from past discussions that there's considerable
 > sentiment on l-k that zip'd patches are undesirable. If the
 > patch is inconveniently large, it can be split into several
 > messages, or placed on an FTP server.  Inconvenient for the
 > developer, maybe, but better for the list as a whole.

Personally, my own stance on attachments (zip or otherwise) is that
they should be below the limit at which my mailhost rejects them. On
at least one mailhost I know, emails over 25k are killed without
notice. My own mailhost kills any over 1,536k so that isn't a problem
for me, but others have much smaller limits.

 > Separately, I think we've spent enough time with the off-topic
 > topic. Perhaps we can move the discussion offline?

Other than your comments, it already is offline...

Best wishes from Riley.

