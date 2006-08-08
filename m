Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964852AbWHHLlV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964852AbWHHLlV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 07:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964862AbWHHLlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 07:41:21 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:18515 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964852AbWHHLlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 07:41:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GJTQhdZ2zojorOHGBU8TnFyeCto9l9avMie0eoTqehMTiMS2xMqU9Dm6UXMt0yfgJ5qwHOILmUoZUinhY4N4PM1lNmSr0tLCWyidyWvDPB7xLDn+lotli7cJqI7M0MwaBYImitrGmvumYOMroRUysZb3waGo9fn+a9li/ZdaTBE=
Message-ID: <f19298770608080441h68fb6696h845b0fd1ed5a7128@mail.gmail.com>
Date: Tue, 8 Aug 2006 15:41:15 +0400
From: "Alexey Zaytsev" <alexey.zaytsev@gmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: Time to forbid non-subscribers from posting to the list?
In-Reply-To: <17624.29292.673708.654588@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <f19298770608080407n5788faa8x779ad84fe53726cb@mail.gmail.com>
	 <17624.29292.673708.654588@cse.unsw.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/06, Neil Brown <neilb@suse.de> wrote:
> On Tuesday August 8, alexey.zaytsev@gmail.com wrote:
> > Hello, list.
> >
> > What are the objections to makeing lkml and other lists at vget
> > subscribers-only?
>
> Yes.  Many.  I think this is in the FAQ. (hhmm.. just looked, it isn't exactly).
>
> > Non-subscribers messages could still be allowed after moderation.
> > I get 1/4 of my spam from lkml, and see no benefit from allowing
> > non-subscribers to freely post to the list. If you are not subscribed,
> > you just have to wait until your mail gets approved by the moderator,
> > and it is not hard to subscribe anyway.
>
> We want to barrier to posting to be low so that people will post bug
> reports.  We want to hear about bug reports. really really.
>
> Were you volunteering to be a moderator?  What sort of minimum delay
> would you guarantee :-)

If we had a large moderators group, we could do mail processing within minutes.
I'm not familiar with any mail list systems, is the mail validation
done with a web-interface?
If we could get incoming traffic delivered to the moderator's mailbox,
rather than appear on the web interface, it would be not hard for him
to ack/nack certain e-mails. We could even get the traffic split
betweem moderators, e.g. one gets N e-mails, afters processing them,
he gets an other N e-mails, and if he does not process theese e-mails
within M hours, they are sent to an other moderator. But here it's
only my imagination, maybe people with some mailing list
administration experience could give more ideas. And yes, if the
moderators group is large enough, I'm ready to come in.

>
> NeilBrown
>
