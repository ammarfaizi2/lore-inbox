Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262322AbSJOBHJ>; Mon, 14 Oct 2002 21:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262324AbSJOBHI>; Mon, 14 Oct 2002 21:07:08 -0400
Received: from stroke.of.genius.brain.org ([206.80.113.1]:34238 "EHLO
	stroke.of.genius.brain.org") by vger.kernel.org with ESMTP
	id <S262322AbSJOBHH>; Mon, 14 Oct 2002 21:07:07 -0400
Date: Mon, 14 Oct 2002 21:12:55 -0400
From: "Murray J. Root" <murrayr@brain.org>
To: linux-kernel@vger.kernel.org
Subject: Re: unhappy with current.h
Message-ID: <20021015011255.GA4098@Master.Wizards>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20021014202404.GA10777@tapu.f00f.org> <Pine.LNX.4.44L.0210142159580.22993-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0210142159580.22993-100000@imladris.surriel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2002 at 10:00:26PM -0200, Rik van Riel wrote:
> On Mon, 14 Oct 2002, Chris Wedgwood wrote:
> > On Mon, Oct 14, 2002 at 09:46:08PM +0200, Daniele Lugli wrote:
> >
> > > I recently wrote a kernel module which gave me some mysterious
> > > problems. After too many days spent in blood, sweat and tears, I found the cause:
> >
> > > *** one of my data structures has a field named 'current'. ***
> >
> > gcc -Wshadow
> 
> Would it be a good idea to add -Wshadow to the kernel
> compile options by default ?
> 

Yes. 

-- 
Murray J. Root
------------------------------------------------
DISCLAIMER: http://www.goldmark.org/jeff/stupid-disclaimers/
------------------------------------------------
Mandrake on irc.freenode.net:
  #mandrake & #mandrake-linux = help for newbies 
  #mdk-cooker = Mandrake Cooker 

