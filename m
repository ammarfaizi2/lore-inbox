Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267686AbTACVpa>; Fri, 3 Jan 2003 16:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267687AbTACVpa>; Fri, 3 Jan 2003 16:45:30 -0500
Received: from adsl-67-114-192-42.dsl.pltn13.pacbell.net ([67.114.192.42]:26889
	"EHLO mx1.corp.rackable.com") by vger.kernel.org with ESMTP
	id <S267686AbTACVoK>; Fri, 3 Jan 2003 16:44:10 -0500
Message-ID: <3E160614.1080809@rackable.com>
Date: Fri, 03 Jan 2003 13:52:20 -0800
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
CC: David Schwartz <davids@webmaster.com>, andrew@walrond.org,
       Marco Monteiro <masm@acm.org>, linux-kernel@vger.kernel.org
Subject: Re: Why is Nvidia given GPL'd code to use in closed source drivers?
References: <20030103164514.GN9166@work.bitmover.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Jan 2003 21:52:29.0644 (UTC) FILETIME=[6970D0C0:01C2B372]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:

>>However, with a license like the GPL, every game has to be developed on a 
>>proprietary base. You simply can't afford to put any money into an open 
>>source base. So every game has to start back from square one, or the most 
>>advanced proprietary base that can be found.
>>    
>>
>
>Back in the heyday of attention to open source, I spent hours and hours
>and hours on the phone with Raymond trying to get the OSI to come up with
>a "business source license" which would address some of these issues.
>think there is a strong need for something like that, but the GPL
>fanatics are desperate to paint the world as black or white and force
>people into an entirely open or entirely closed choice.  The reason they
>want to do this is that they know darn well that it is always the middle
>of the road compromise which wins, and they don't want to compromise.
>So we get these endless tirades about how the GPL is the One True Way
>and anything else is Evil.
>
>It was most unfortunate that I couldn't get anywhere with ESR.  If he and
>the OSI had come up with some compromises, rather than just pandering to a
>small but vocal group, I think that he would have cemented a significant
>place in history.  I am positive that the world will eventually move in
>directions where there is some sort of compromise, maybe something like
>you get N years of closed use and then the old stuff has to be opened,
>whatever.  The world already understands that you need to make money to
>survive and the world is starting to understand that there is value in
>having things be open.  
>
Well the 2 most obvious licenses would be usage based and escrow like.

1)  In a usage based license you would be required to posses a license 
to use the software.  You would posses the source,  permission to make 
modification, and permission to use the resulting binaries.  Ideally the 
license would also allow redistribution of patches, and reselling licenses.

   This is the sort of license I think Microsoft should be persuing with 
their larger customers.  Giving your customer source, with the ability 
to use modified binaries is just silly.  As far as games go you can see 
how this would work and stimulate sales just by looking at the mod 
community for Tribes, or Quake.  Or the use of the various 3D engines by 
3rd parties.

  While some would argue that this leaves you open to piracy.  Let's be 
honest how many pirates compile anything.  At most they disable the copy 
protection with hex-editor.

2)Escrow licenses are fairly common in business today for various types 
of custom software.  In essence the source is held by a 3rd party and 
given to the customer if the licenser is in breach of contract.   I can 
easily see a license not requiring a third party, but simply stating 
that the source would be released upon the software becoming 
unsupported, after a time frame, or if the vendor failed to address a 
certain class of bug within a time frame.

There is no such thing as obsolete hardware.
Merely hardware that other people don't want.
(The Second Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>



