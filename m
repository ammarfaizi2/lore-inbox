Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265659AbRGSRww>; Thu, 19 Jul 2001 13:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265714AbRGSRwm>; Thu, 19 Jul 2001 13:52:42 -0400
Received: from unthought.net ([212.97.129.24]:25313 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S265659AbRGSRw2>;
	Thu, 19 Jul 2001 13:52:28 -0400
Date: Thu, 19 Jul 2001 19:52:31 +0200
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Andi Kleen <ak@suse.de>
Cc: Cornel Ciocirlan <ctrl@rdsnet.ro>, linux-kernel@vger.kernel.org
Subject: Re: Request for comments
Message-ID: <20010719195231.B31165@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Andi Kleen <ak@suse.de>, Cornel Ciocirlan <ctrl@rdsnet.ro>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0107191757400.17990-100000@groove.rdsnet.ro.suse.lists.linux.kernel> <oup4rs8kenl.fsf@pigdrop.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <oup4rs8kenl.fsf@pigdrop.muc.suse.de>; from ak@suse.de on Thu, Jul 19, 2001 at 07:33:02PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Thu, Jul 19, 2001 at 07:33:02PM +0200, Andi Kleen wrote:
> Cornel Ciocirlan <ctrl@rdsnet.ro> writes:
> 
> > Hi, 
> > 
> > I was thinking of starting a project to implement a Cisco-like
> > "NetFlow" architecture for Linux. This would be relevant for edge routers
> > and/or network monitoring devices.  
> 
> Linux 2.1+ already has such a cache in form of the rtcache since several
> years.

NeTraMet is a project that will give you NetFlow-like data.  You set up traffic
meters on your routers, and gather data centrally from the meters using SNMP.

Works great.

See: http://www2.auckland.ac.nz/net/Accounting/ntm.Release.note.html

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
