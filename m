Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932088AbWHHMDK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbWHHMDK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 08:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932118AbWHHMDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 08:03:10 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:17601 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932088AbWHHMDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 08:03:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TYvm9+NtzluHuctNr1jEWJ5TSaMBy+6g1JH1yz66S+DYn2kwA0mis/fSMIVIVxj/IzG2Vpw1TF9Vuv3Pn4K1UGtQiJKdopY8xCzIVZ4dbffm4snYS1LiGz4l13E4lQqtb5SG1896KnOfW0glYXtwFLR/2WbKuoodRbNl3gkxxNw=
Message-ID: <f19298770608080503l349899cftc421239d1985bb3@mail.gmail.com>
Date: Tue, 8 Aug 2006 16:03:07 +0400
From: "Alexey Zaytsev" <alexey.zaytsev@gmail.com>
To: "Jes Sorensen" <jes@sgi.com>
Subject: Re: Time to forbid non-subscribers from posting to the list?
Cc: "Andi Kleen" <ak@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <yq03bc7v3uy.fsf@jaguar.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <f19298770608080407n5788faa8x779ad84fe53726cb@mail.gmail.com>
	 <p73y7tzo4hl.fsf@verdi.suse.de>
	 <f19298770608080447l3e31465fqb6fbc8cfed71cb80@mail.gmail.com>
	 <yq03bc7v3uy.fsf@jaguar.mkp.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08 Aug 2006 07:55:33 -0400, Jes Sorensen <jes@sgi.com> wrote:
> >>>>> "Alexey" == Alexey Zaytsev <alexey.zaytsev@gmail.com> writes:
>
> Alexey> On 08 Aug 2006 13:23:50 +0200, Andi Kleen <ak@suse.de> wrote:
> >> You would make bug reports impossible from normal people who don't
> >> want to subscribe fully. It would totally wreck the development
> >> model.
> Alexey> If they don't want to subscribe, they can just report to the
> Alexey> list as usual, theyr mail will be only slightly delayed
> Alexey> because of moderation.  We could even use some sort of white
> Alexey> lists, if a user's mail was once approved, all his further
> Alexey> mail will be accepthed without moderation.
>
> At 400-500 mails per day, who is going to handle the moderation? Sure
> only a portion would be held back, but there's plenty other work to do
> and we want fast turnaround for user bug reports, so if a user is
> asked a question he/she can respond quickly with more details.

I'm sure not all the 500 mails are from non-subscribers, and, as I
told, we could split
the traffic between a large number of moderators.

>
> Moderation is a bad idea, right up there with C++ kernel modules, and
> splitting the source code into smaller tarballs. For some reason they
> all seem to get proposed again and again on a semi regular basis. If
> people would just read the archives.....

Ok, if this idea was discussed repeatedly, I'll giveup.

>
> Just install a proper spam filter like everyone else.
>
> Jes
>
