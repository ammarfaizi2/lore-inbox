Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131669AbRDFPKX>; Fri, 6 Apr 2001 11:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131672AbRDFPKO>; Fri, 6 Apr 2001 11:10:14 -0400
Received: from filesrv1.baby-dragons.com ([199.33.245.55]:21003 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id <S131669AbRDFPKC>; Fri, 6 Apr 2001 11:10:02 -0400
Date: Fri, 6 Apr 2001 08:08:21 -0700 (PDT)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Artur Frysiak <artur.frysiak@buy.pl>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: syslog insmod please!
In-Reply-To: <20010406165451.C1503@free.buy.pl>
Message-ID: <Pine.LNX.4.32.0104060805360.17426-100000@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello Wichert ,
On Fri, 6 Apr 2001, Artur Frysiak wrote:
> On Fri, Apr 06, 2001 at 07:43:29AM -0700, Mr. James W. Laferriere wrote:
> > On 6 Apr 2001, Wichert Akkerman wrote:
> > > In article <Pine.LNX.4.32.0104060429500.17426-100000@filesrv1.baby-dragons.com>,
> > > Mr. James W. Laferriere <babydr@baby-dragons.com> wrote:
> > > >	Not the problem being discussed ,  This is a user now root &
> > > >	having gained root is now attempting to from the command line
> > > >	to load a module .  How do we get this event recorded ?
> > > Recent versions of modutils (2.4.3 and later iirc) log that info
> > > in /var/log/ksymoops

> But r00tkit may have own version of insmod.
	OK ,  There are no special features accorded to /var/log/ksymoops
	than to any other file .  Unless otherwise configured .
	Am I that mistaken ?  I hope not .  Tia ,  JimL

       +----------------------------------------------------------------+
       | James   W.   Laferriere | System  Techniques | Give me VMS     |
       | Network        Engineer | 25416      22nd So |  Give me Linux  |
       | babydr@baby-dragons.com | DesMoines WA 98198 |   only  on  AXP |
       +----------------------------------------------------------------+

