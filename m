Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310612AbSCHAbQ>; Thu, 7 Mar 2002 19:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310623AbSCHAbG>; Thu, 7 Mar 2002 19:31:06 -0500
Received: from austin.openmic.com ([216.143.252.250]:60684 "EHLO
	austin.openmic.com") by vger.kernel.org with ESMTP
	id <S310612AbSCHAay>; Thu, 7 Mar 2002 19:30:54 -0500
Message-ID: <3C8805EC.3000602@greshamstorage.com>
Date: Thu, 07 Mar 2002 18:29:32 -0600
From: "Jonathan A. George" <JGeorge@greshamstorage.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8+) Gecko/20020226
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel SCM: When does CVS fall down where it REALLY matters?
In-Reply-To: <Pine.LNX.4.44L.0203072057510.2181-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:

>On Thu, 7 Mar 2002, Jonathan A. George wrote:
>
>>I am considering adding some enhancements to CVS to address deficiencies
>>which adversely affect my productivity.
>>
>
>>... I would like to know what the Bitkeeper users consider the minimum
>>acceptable set of improvements that CVS would require for broader
>>acceptance.
>>
>
>1) working merges
>
Can you be more specific?

>2) atomic checkins of entire patches, fast tags
>
I was thinking about something like automatically tagged globally 
descrete patch sets.  It would then be fairly simple to create a tool 
that simply scanned, merged, and checked in that patch as a set.  Is 
something like this what you have in mind?

>3) graphical 2-way merging tool like bitkeeper has
>   (this might not seem essential to people who have
>   never used it, but it has saved me many many hours)
>
Would having something like VIM or Emacs display a patch diff with 
providing keystroke level merge and unmerge get toward helpful for 
something like this, or is the need too complex to address that way?

>4) distributed repositories
>
Can you be more specific?  (i.e. are you looking for merging, 
syncronization, or copies?  In other words what do you need that CVS + 
rsync are unacceptable for?)

>5) ability to exchange changesets by email
>
That's a good one, and shouldn't be too bad if you like what I said for #2

>regards,
>
>Rik
>

--Jonathan--

