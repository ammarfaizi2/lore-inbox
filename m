Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261662AbTCHA6B>; Fri, 7 Mar 2003 19:58:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261576AbTCHA5w>; Fri, 7 Mar 2003 19:57:52 -0500
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:1679 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S261662AbTCHA5W>; Fri, 7 Mar 2003 19:57:22 -0500
Message-ID: <3E6942C9.1040204@kegel.com>
Date: Fri, 07 Mar 2003 17:09:29 -0800
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: Werner Almesberger <wa@almesberger.net>
CC: Dave Jones <davej@codemonkey.org.uk>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Benjamin LaHaise <bcrl@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Those ruddy punctuation fixes
References: <3E684737.7080704@kegel.com> <20030307121723.B3204@redhat.com> <1047078959.23697.12.camel@irongate.swansea.linux.org.uk> <20030308005241.GA24077@suse.de> <20030307212925.S2791@almesberger.net>
In-Reply-To: <20030307212925.S2791@almesberger.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner Almesberger wrote:
> One problem with spelling fixes is that there's never a good
> moment, nor a good procedure to do them.
> 
> 
>>There are _dozens_ of known problems, and I'll take patches
>>fixing real problems over spelling fixes any day.
> 
> 
> I guess it would be nice if Linus would give some advance warning
> when he's going to accept speelnig fixes. That way, people with
> "real work" could schedule a few weeks at the beach, while the
> spelling police does its grisly job.
> 
> Of course, we all know that this will never happen ;-)

The next best thing might be for the spelling police
to maintain an archive of all the accepted spellfix patches.
That would let a sufficiently motivated person
(say, a spelling policeman) to offer a patch update
service with a reasonable certainty that he could
bring arbitrary patches up to date with respect to
the spellfixes in the main tree.
I've outlined a proposal for this at http://www.kegel.com/kerspell

This spellfix business is way more work than is reasonable.
The people who spend the time making it work while taking
care of all these issues (avoiding pun removal, avoiding
breakage, avoiding wrong corrections, patch updating)
are clearly on acid, but I salute them.  Me, I just take
notes and watch :-)
- Dan

-- 
Dan Kegel
http://www.kegel.com
http://counter.li.org/cgi-bin/runscript/display-person.cgi?user=78045

