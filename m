Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289643AbSAJTzK>; Thu, 10 Jan 2002 14:55:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289640AbSAJTzA>; Thu, 10 Jan 2002 14:55:00 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:21120 "EHLO
	zcars0m9.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S289643AbSAJTys>; Thu, 10 Jan 2002 14:54:48 -0500
Message-ID: <3C3DF2DE.2316D13E@nortelnetworks.com>
Date: Thu, 10 Jan 2002 15:00:30 -0500
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <E16OUu0-00035o-00@the-village.bc.nu> <200201101753.g0AHrlA17591@snark.thyrsus.com> <3C3DDEA9.E8FAB8DC@nortelnetworks.com> <20020110203655.H5235@khan.acc.umu.se>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Weinehall wrote:
> 
> On Thu, Jan 10, 2002 at 01:34:17PM -0500, Chris Friesen wrote:

> > If I'm trying to watch a DVD on my computer, and assuming my CPU is powerful
> > enough to decode in realtime, then I want the DVD player to take
> > priority--dropping frames just because I'm starting up netscape is not
> > acceptable.
> 
> Ummm, and you couldn't consider refraining from firing up Netscape
> while watching the DVD, could you?!
> 
> I get your point, but the example was poorly chosen, imho.

I chose netscape because it is probably the largest single app that I have on my
machine.  Other possibilities would be running a kernel compile, a recursive
search for specific file content through the entire filesystem, or anything else
that is likely to cause problems. It might even be someone else in the house
logged into it and running stuff over the network.


-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
