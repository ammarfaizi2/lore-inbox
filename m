Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286756AbSAIOEi>; Wed, 9 Jan 2002 09:04:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286692AbSAIOEd>; Wed, 9 Jan 2002 09:04:33 -0500
Received: from dsl-213-023-043-044.arcor-ip.net ([213.23.43.44]:53252 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S286712AbSAIOEO>;
	Wed, 9 Jan 2002 09:04:14 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Date: Wed, 9 Jan 2002 15:07:40 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Robert Love <rml@tech9.net>, Anton Blanchard <anton@samba.org>,
        Luigi Genoni <kernel@Expansa.sns.it>,
        Dieter N?tzel <Dieter.Nuetzel@hamburg.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Rik van Riel <riel@conectiva.com.br>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@zip.com.au>
In-Reply-To: <20020108030420Z287595-13997+1799@vger.kernel.org> <E16OHLf-0000Dn-00@starship.berlin> <20020109145509.G1543@inspiron.school.suse.de>
In-Reply-To: <20020109145509.G1543@inspiron.school.suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16OJOJ-0000Q6-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 9, 2002 02:55 pm, Andrea Arcangeli wrote:
> On Wed, Jan 09, 2002 at 12:56:50PM +0100, Daniel Phillips wrote:
> > BTW, I find your main argument confusing.  First you don't want -preempt with
> > CONFIG_EXERIMENTAL because it might not get wide enough testing, so you want 
> > to enable it by default in the mainline kernel, then you argue it's too risky 
> > because everybody will use it and it might break some obscure driver.  Sorry, 
> > you lost me back there.
> 
> the point I am making is very simple: _if_ we include it, it should _not_
> be a config option.

That doesn't make any sense to me.  Why should _SMP be a config option and not
_PREEMPT?

--
Daniel
