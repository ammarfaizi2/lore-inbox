Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131446AbRDFO4m>; Fri, 6 Apr 2001 10:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131659AbRDFO4d>; Fri, 6 Apr 2001 10:56:33 -0400
Received: from free.buy.pl ([213.77.43.228]:49159 "HELO free.buy.pl")
	by vger.kernel.org with SMTP id <S131446AbRDFO4N>;
	Fri, 6 Apr 2001 10:56:13 -0400
Date: Fri, 6 Apr 2001 16:54:51 +0200
From: Artur Frysiak <artur.frysiak@buy.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: syslog insmod please!
Message-ID: <20010406165451.C1503@free.buy.pl>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <9akic6$v0c$1@picard.cistron.nl> <Pine.LNX.4.32.0104060730530.17426-100000@filesrv1.baby-dragons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <Pine.LNX.4.32.0104060730530.17426-100000@filesrv1.baby-dragons.com>; from babydr@baby-dragons.com on Fri, Apr 06, 2001 at 07:43:29AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 06, 2001 at 07:43:29AM -0700, Mr. James W. Laferriere wrote:
> 
> 	Hello Wichert ,
> 
> On 6 Apr 2001, Wichert Akkerman wrote:
> > In article <Pine.LNX.4.32.0104060429500.17426-100000@filesrv1.baby-dragons.com>,
> > Mr. James W. Laferriere <babydr@baby-dragons.com> wrote:
> > >	Not the problem being discussed ,  This is a user now root &
> > >	having gained root is now attempting to from the command line
> > >	to load a module .  How do we get this event recorded ?
> > Recent versions of modutils (2.4.3 and later iirc) log that info
> > in /var/log/ksymoops

But r00tkit may have own version of insmod.

Regards
-- 
Artur Frysiak
Click and Buy Sp. z o.o.
tel. (071) 327-95-00 wew. 67
tel. GSM (0606) 506-414
