Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264062AbRFTQ3Y>; Wed, 20 Jun 2001 12:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264064AbRFTQ3O>; Wed, 20 Jun 2001 12:29:14 -0400
Received: from sncgw.nai.com ([161.69.248.229]:44461 "EHLO mcafee-labs.nai.com")
	by vger.kernel.org with ESMTP id <S264062AbRFTQ3C>;
	Wed, 20 Jun 2001 12:29:02 -0400
Message-ID: <XFMail.20010620093214.davidel@xmailserver.org>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <3B30C4D2.30915E4@247media.com>
Date: Wed, 20 Jun 2001 09:32:14 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: Russell Leighton <russell.leighton@247media.com>
Subject: Re: [OT] Threads, inelegance, and Java
Cc: linux-kernel@vger.kernel.org, Ben Greear <greearb@candelatech.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20-Jun-2001 Russell Leighton wrote:
> Ben Greear wrote:
> <snip>
> 
>> System-design and elegance are easy to get
>> in Java, and in fact are independent of language.  Good c code will beat
>> Java in most cases, performance wise, but lately the difference has become
>> small enough not to matter for most applications.
> 
> Rather a sweeping statement.
> 
> I don't buy it...depends what you mean by "most applications".
> I bet 90% of the  "most"  would be better served by
> being written in Visual Basic (or Perl, or Python, or PHP pick your poison
> for a very high level language)...and if you really care about
> resource usage and/or performance you don't
> want a very high high level language and Java does not leap to mind
> as part of the set of credible alternatives.
> 
> I had a company that gaves us a tech briefing of their system.
> They dumped mega-bucks into multiple Sun E10000s they needed to run their
> Java apps...
> the were proud of their scalable design, just add more hardware!
> True, the high level design was fine and trivially scalable w/more hw BUT
> what a waste, if their app was done in C they could have
> had it run faster and it would have cost them significantly less (in the
> millions of $$).

1) HW is cheaper than software engineers time

2) to find Java developers is easier than to find C developers

3) the ETA of the same project developed in Java is shorter than the same
        project done in C


This depend heavily on the type of project but these are points that every
software Co. has to face when starting a new project.




- Davide

