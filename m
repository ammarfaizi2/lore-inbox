Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261955AbSJJSfK>; Thu, 10 Oct 2002 14:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262021AbSJJSfJ>; Thu, 10 Oct 2002 14:35:09 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:64013 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261955AbSJJSe7>;
	Thu, 10 Oct 2002 14:34:59 -0400
Date: Thu, 10 Oct 2002 11:36:35 -0700
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, johnstul@us.ibm.com
Subject: Re: [BK PATCH] i386 timer changes for 2.5.41
Message-ID: <20021010183635.GE25871@kroah.com>
References: <20021010182652.GA25871@kroah.com> <Pine.LNX.4.44.0210101132300.4124-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210101132300.4124-100000@penguin.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2002 at 11:33:38AM -0700, Linus Torvalds wrote:
> 
> On Thu, 10 Oct 2002, Greg KH wrote:
> > 
> > I've taken the i386 timer.c patches that John Stultz has been working on
> > for a while
> 
> Hmm, I was getting to them anyway, this would make it easier. 
> 
> Except for the fact that I get
> 
> 	[torvalds@penguin linux]$ bk pull bk://lsm.bkbits.net/timer-2.5
> 	ERROR-cannot cd to timer-2.5 (illegal, nonexistant, or not package root)
> 
> when I try to check it out..

Argh, wrong repo, try this:
	bk://linuxusb.bkbits.net/timer-2.5

Sorry about that.

greg k-h
(drowning in different bk trees...)
