Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319049AbSH1XMV>; Wed, 28 Aug 2002 19:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319052AbSH1XMV>; Wed, 28 Aug 2002 19:12:21 -0400
Received: from hq.fsmlabs.com ([209.155.42.197]:50622 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S319049AbSH1XMT>;
	Wed, 28 Aug 2002 19:12:19 -0400
Date: Wed, 28 Aug 2002 17:14:48 -0600
From: yodaiken@fsmlabs.com
To: linux-kernel@vger.kernel.org
Subject: Re: Re: TUX2 filesystem
Message-ID: <20020828171448.A6401@hq.fsmlabs.com>
References: <200208262006.g7QK6uH29932@marc2.theaimsgroup.com> <E17jWuh-0002bx-00@starship> <20020829004935.A7939@unicyclist.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020829004935.A7939@unicyclist.com>; from imcol@unicyclist.com on Thu, Aug 29, 2002 at 12:49:35AM +0200
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2002 at 12:49:35AM +0200, Daniel Mose wrote:
> Well perhaps the patent part, but I sort of got curious 
> on it, by this posting. Is there any patches or documentation 
> available. I'm going to put my nose deep into the world of 
> experimental file systems this winter, and hopefully come up with 
> something useful, so I would appreciate anything that describes 
> it's general ideas.


See:

Borg, Wolfgang Blau, Wolfgang Graetsch, Ferdinand Herrmann, Wolfgang Oberle: Fault Tolerance Under UNIX. TOCS 7(1): 1-24 (1989)
1986

also:

Anita Borg, Wolfgang Blau, Wolfgang Oberle, Wolfgang Graetsch: Fault Tolerance in Distributed UNIX. Fault-Tolerant Distributed Computing 1986: 224-243
1983
 Anita Borg, Jim Baumbach, Sam Glazer: A Message System Supporting Fault Tolerance. SOSP 1983: 90-99


The earliest description I've heard of this idea was from Sam Glazer in 1982.


-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

