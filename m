Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265391AbTLRXLO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 18:11:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265394AbTLRXLO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 18:11:14 -0500
Received: from opersys.com ([64.40.108.71]:39438 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S265391AbTLRXLI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 18:11:08 -0500
Message-ID: <3FE234C1.9030904@opersys.com>
Date: Thu, 18 Dec 2003 18:14:09 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Victor Yodaiken <yodaiken@fsmlabs.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>, rtai-dev <rtai-dev@rtai.org>
Subject: Latest statements regarding real-time in Linux
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Victor,

I am writing to you today regarding your latest statements about
various issues pertaining to Linux's use in real-time applications:
http://linuxdevices.com/articles/AT4817784412.html

As you probably remember, the last time this topic was discussed on
the LKML, quite a few kernel developers were unaware of the real
facts regarding Linux's difficulties of being adopted in the
real-time field and the evolution of the various projects providing
real-time capabilities in Linux, including RTLinux and RTAI. My
CC'ing of the LKML is to make sure that those interested are kept
aware of the various developments.

I do not wish to rekindle the May 2002 debate. However, I do ask
you to refrain from further harming Linux's adoption in an entire
application field by making statements such as those you make in
the above-mentioned article.

Specifically, I would like to bring to your attention the following
items:

A) Contrary to the characterization you make in the interview, RTAI
is licensed under the GPL. Its licensing is clear.

B) The similarity of code between some parts of RTAI and RTLinux
traces its origin back to the initial development mailing list
exchanges between both development teams, as recognized by your
own employees/contractors:
http://marc.theaimsgroup.com/?l=linux-kernel&m=102240777026651&w=2

C) Eben Moglen's statements regarding "Applications" being
excluded from the patent are not at all unclear. It is noteworthy,
nevertheless, that this is the second time that you find it
pertinent to try attacking that exact same statement.

D) You remain true to yourself in making the following ad-hominem
comment: "I doubt Adeos avoids the patent - but that's a guess
based only on the reliability of people claiming it does." I
figure you have two possible choices regarding Adeos:
1) You claim it is subject to the patent: but then you destroy
your patent by admitting that their is blatant prior art since
Adeos is based entirely on scientific publications published
more than one year prior to the preliminary patent filling.
2) You claim it isn't subject to the patent: but then everyone
uses Adeos to obtain deterministic response times and you close
up shop.
Neither of these are realistic choices for you, so you do as you
always did before: cast doubts out of thin air and attack the
credibility of those making the statements. In case you had not
noticed, Adeos' claim of being patent-free was endorsed by quite
a few free software and open source organizations (See here for
a list: http://lwn.net/Articles/1222/). At various times,
including during the LKML discussion following Adeos' release,
quite a few individuals have come out to agree with Adeos'
claim of being patent free, including Daniel Philipps and
Alessandro Rubini. I can understand that you will always find me
to be unreliable since I'm not playing to your tune, but you
can surely see that questioning the reliability of people like
Daniel or Alessandro isn't really the way to go. In other words,
if you have real technical reasons you want to present as to why
you think Adeos is subject to the patent I'm all ears. Otherwise,
please stop spreading FUD and making ad-hominem attacks.

E) In regards to your statement: "Just calling something an
application or creating an artificial barrier does not automatically
escape the requirements of either the GPL or the Open Patent
License." In terms of the "Open Patent License"'s applicability
to applications, Eben Moglen's words remain the definitive statement
on this issue. As for your statement that the GPL propagates to
user-space, then I refer you to the kernel's copyright statement.

E') I think it is fair to say that RTLinux is a derived work of
Linux. Hence, the recent discussion regarding the GPL's applicability
to various software interacting with the kernel very much applies to
RTLinux. So, if the GPL applies to user-space real-time applications,
as you say it does, then, to the best of my understanding,
RTLinux developers are not allowed to distribute either kernel-module
rtlinux apps or user-space rtlinux apps under any other license than
the GPL.

I personally find it rather cynical that within the same interview
where you try to create as much legal uncertainty as possible
regarding Linux's use in real-time applications, you somehow find
it to criticize SCO's behavior. But that's probably just my sense
of morality being hyper-sensitive. You're in this for the money
as I understand it, and business is business.

My personal impressions aside, I appreciate the attention you
will bring to the items outlined above.

Respectfully,

Karim Yaghmour
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 514-812-4145





