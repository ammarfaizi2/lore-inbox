Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267360AbSKPVD0>; Sat, 16 Nov 2002 16:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267361AbSKPVD0>; Sat, 16 Nov 2002 16:03:26 -0500
Received: from stroke.of.genius.brain.org ([206.80.113.1]:53425 "EHLO
	stroke.of.genius.brain.org") by vger.kernel.org with ESMTP
	id <S267360AbSKPVDY>; Sat, 16 Nov 2002 16:03:24 -0500
Date: Sat, 16 Nov 2002 16:08:31 -0500
From: "Murray J. Root" <murrayr@brain.org>
To: linux-kernel@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       Gerhard Mack <gmack@innerfire.net>, Larry McVoy <lm@bitmover.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: Bugzilla bug tracking database for 2.5 now available.
Message-ID: <20021116210831.GA15533@Master.Wizards>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Gerhard Mack <gmack@innerfire.net>, Larry McVoy <lm@bitmover.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	"David S. Miller" <davem@redhat.com>
References: <20021115132304.M19291@work.bitmover.com> <Pine.LNX.4.44.0211160209180.18309-100000@innerfire.net> <20021116071750.GR16673@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021116071750.GR16673@conectiva.com.br>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 16, 2002 at 05:17:50AM -0200, Arnaldo Carvalho de Melo wrote:
> Em Sat, Nov 16, 2002 at 02:10:13AM -0500, Gerhard Mack escreveu:
> > On Fri, 15 Nov 2002, Larry McVoy wrote:
>  
> > > This is not an easy problem space, on the one hand you want to have all
> > > bugs tracked, on the other hand, trivial bugs in the bug db just make the
> > > bug db unusable.  No engineer is going to put up with 100,000 stupid bug
> > > reports.  You need a plan to get rid of those or keep them out of the bugdb
> > > or it's unlikely to get used by the people who really need to use it.
> 
> > Or the bugs could just be assigned to whoever owns the patchset ...
> 
> or the tickets could just be closed after, say, one month without activity.
> 
> If it is really a bug it'll be resubmitted after a while, its not as we'll not
> have duplicates anyway...
>
 
Very bad idea. People using unusual hardware do not want to keep 
re-submitting a bug report. I know when I submit a report I expect that
it will remain until the problem is fixed. I do not like to receive
multiple copies of a bug report so I don't submit multiple copies unless
it's going to be helpful (like pointing out different versions that 
exhibit the problem). If I thought my report was just going to get 
dropped because the developer was busy that month I wouldn't bother to
submit at all. I'd rather wait 6 months for a fix knowing that the 
report is still in the database than just have it dropped.

-- 
Murray J. Root
------------------------------------------------
DISCLAIMER: http://www.goldmark.org/jeff/stupid-disclaimers/
------------------------------------------------
Mandrake on irc.freenode.net:
  #mandrake & #mandrake-linux = help for newbies 
  #mdk-cooker = Mandrake Cooker 

