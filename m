Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287598AbSAURxo>; Mon, 21 Jan 2002 12:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287625AbSAURxe>; Mon, 21 Jan 2002 12:53:34 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:41483 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S287598AbSAURx1>;
	Mon, 21 Jan 2002 12:53:27 -0500
Date: Mon, 21 Jan 2002 10:52:37 -0700
From: yodaiken@fsmlabs.com
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: yodaiken@fsmlabs.com, Daniel Phillips <phillips@bonn-fries.net>,
        george anzinger <george@mvista.com>, Momchil Velikov <velco@fadata.bg>,
        Arjan van de Ven <arjan@fenrus.demon.nl>,
        Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020121105237.A15414@hq.fsmlabs.com>
In-Reply-To: <E16PZbb-0003i6-00@the-village.bc.nu> <E16SgwP-0001iN-00@starship.berlin> <20020121090602.A13715@hq.fsmlabs.com> <E16ShcU-0001ip-00@starship.berlin> <20020121095051.B14139@hq.fsmlabs.com> <3C4C50C9.8C7D5B6F@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3C4C50C9.8C7D5B6F@nortelnetworks.com>; from cfriesen@nortelnetworks.com on Mon, Jan 21, 2002 at 12:32:57PM -0500
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, Jan 21, 2002 at 12:32:57PM -0500, Chris Friesen wrote:
> yodaiken@fsmlabs.com wrote:
> 
> > So your claim is that:
> >         Preemption improves latency when there are both kernel cpu bound
> >         tasks and tasks that are I/O bound with very low cache hit
> >         rates?
> > 
> > Is that it?
> > 
> > Can you give me an example of a CPU bound task that runs
> > mostly in kernel? Doesn't that seem like a kernel bug?
> 
> cat /dev/urandom > /dev/null

Don't see any of Daniel's postulated long latencies there.  (Sorry, but
I'm having a hard time figuring out what is meant as a serious comment
here).


> 
> -- 
> Chris Friesen                    | MailStop: 043/33/F10  
> Nortel Networks                  | work: (613) 765-0557
> 3500 Carling Avenue              | fax:  (613) 765-2986
> Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

