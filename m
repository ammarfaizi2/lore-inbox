Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262133AbTJ3DkL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 22:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262149AbTJ3DkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 22:40:11 -0500
Received: from h1ab.lcom.net ([216.51.237.171]:34947 "EHLO digitasaru.net")
	by vger.kernel.org with ESMTP id S262133AbTJ3DkD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 22:40:03 -0500
Date: Wed, 29 Oct 2003 21:39:53 -0600
From: Joseph Pingenot <trelane@digitasaru.net>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Dax Kelson <dax@gurulabs.com>, Hans Reiser <reiser@namesys.com>,
       andersen@codepoet.org, linux-kernel@vger.kernel.org
Subject: Re: Things that Longhorn seems to be doing right
Message-ID: <20031030033951.GC15309@digitasaru.net>
Reply-To: trelane@digitasaru.net
Mail-Followup-To: Neil Brown <neilb@cse.unsw.edu.au>,
	Dax Kelson <dax@gurulabs.com>, Hans Reiser <reiser@namesys.com>,
	andersen@codepoet.org, linux-kernel@vger.kernel.org
References: <3F9F7F66.9060008@namesys.com> <20031029224230.GA32463@codepoet.org> <3FA0475E.2070907@namesys.com> <1067466349.3077.274.camel@mentor.gurulabs.com> <20031030002005.GC3094@digitasaru.net> <16288.24913.844699.956689@notabene.cse.unsw.edu.au> <20031030013418.GD3094@digitasaru.net> <16288.33392.379456.626398@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16288.33392.379456.626398@notabene.cse.unsw.edu.au>
X-School: University of Iowa
X-vi-or-emacs: vi *and* emacs!
X-MSMail-Priority: High
X-Priority: 1 (Highest)
X-MS-TNEF-Correlator: <AFJAUFHRUOGRESULWAOIHFEAUIOFBVHSHNRAIU.monkey@spamcentral.invalid>
X-MimeOLE: Not Produced By Microsoft MimeOLE V5.50.4522.1200
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Neil Brown on Thursday, 30 October, 2003:
>On Wednesday October 29, trelane@digitasaru.net wrote:
>> "Sounds like?"  Sure.  It kind of does, now that you mention it.
>> Regradless of the similarities and the validity of Pascal's argument, my
>>   argument, I think, stands.  I outlined the four potential futures.  We
>>   have control over only one bit, Microsoft has the other.  The tech sounds
>>   nice, it is an interesting avenue to persue, Pascal aside.
>> I don't see any reason why we *shouldn't* look at the problem and try to
>>   do it.  What reasons do you see for not persuing the problem to its
>>   inevitible implementation?
> There are lots of other interesting problems.  Why persue this one?
>(as with Pascal: there are many who claim to be "god" and demand
> worship, which do you follow).
> That doesn't mean you shouldn't pursue this one.  It just means that
> you haven't given a good reason.
>  "Microsoft might do something that we haven't so we should" isn't a
>  good reason.
>  "I find this interesting" or "I have an immediate need for this" are
>  both good reasons, and if they apply, then by all means, pursue it.
>> I see big pitfalls in *not* looking at the problem.  In what respect are
>>   the pitfalls of ignoring it as outlined by me invalid?
> The future is full of pits that we cannot see, and many that we do
> see are mirages.
> Your main pitfall seems to be patents.  There are lots of patents out
> there that might be a problem, and lots more that will undoubtedly be
> taken out.  Why target this one?
> History seems to suggest that patents for seriously clever ideas
> aren't a problem.  It is usually possible to come up with a different
> clever idea that achieves the same end (I gather the RTLinux patent
> has been avoided that way, but I don't follow RT much. gzip and
> vorbis are other examples).  It is mainly the trivial patents that
> are a problem. 

Excellent points.  I see your counterargument much better now, thank you.

I do think it's an interesting tech of potential value.  Only time will
  tell if it's worth it, and for whom it might be valuable.

>If you look at your argument, you will see that it gives no hint of
>what the technology is that we might be wanting to persue.  It is
>purely a "Microsoft ways they will do it, so I think we should to"
>argument, and there are many things that Microsoft do that I
>definately don't think we should do.

True.  I was likely being a little overly anxious that Linux might fall behind
  in something.  That said, ignoring the stated intentions of the others,
  especially those who seek to destroy your stuff, shouldn't be taken
  lightly.  I'd really like to see it persued in FOSS, 'cause it's
  potentially interesting for various types of people ('knowledge worker'
  buzzword aside; I do see some potential applications if there's a way
  to keep track of the content of various files (e.g. .desktop files).  I'm
  sure there are plenty of people smarter and/or more creative than I
  who can think of even more useful stuff to do with improved indexing.

I don't think that it was purely a case of following Microsoft, and I
  definitely concur that there are many things that Microsoft does that
  we should not.

>[Just for the record 
>  - I don't think database transaction support should go in the kernel.

I agree.  Generally, the less that goes in the kernel, the better, IMHO.

>    I'd rather take things out of filesystems than put them in.

Not sure if I completely agree.  I do agree with simplicity being
  generally the best course.  Generally, however, should be emphasized.

>  - I do think there is a God worth worshiping

Agreed.  Others likely disagree.  ;)

>]

-- 
Joseph===============================================trelane@digitasaru.net
"Asked by CollabNet CTO Brian Behlendorf whether Microsoft will enforce its
 patents against open source projects, Mundie replied, 'Yes, absolutely.'
 An audience member pointed out that many open source projects aren't
 funded and so can't afford legal representation to rival Microsoft's. 'Oh
 well,' said Mundie. 'Get your money, and let's go to court.' 
Microsoft's patents only defensive? http://swpat.ffii.org/players/microsoft
