Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267366AbSKPVfC>; Sat, 16 Nov 2002 16:35:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267367AbSKPVfC>; Sat, 16 Nov 2002 16:35:02 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:12042 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S267366AbSKPVfB>; Sat, 16 Nov 2002 16:35:01 -0500
Date: Sat, 16 Nov 2002 19:41:40 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: linux-kernel@vger.kernel.org, Gerhard Mack <gmack@innerfire.net>,
       Larry McVoy <lm@bitmover.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: Bugzilla bug tracking database for 2.5 now available.
Message-ID: <20021116214140.GP24641@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	linux-kernel@vger.kernel.org, Gerhard Mack <gmack@innerfire.net>,
	Larry McVoy <lm@bitmover.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	"David S. Miller" <davem@redhat.com>
References: <20021115132304.M19291@work.bitmover.com> <Pine.LNX.4.44.0211160209180.18309-100000@innerfire.net> <20021116071750.GR16673@conectiva.com.br> <20021116210831.GA15533@Master.Wizards>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021116210831.GA15533@Master.Wizards>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Nov 16, 2002 at 04:08:31PM -0500, Murray J. Root escreveu:
> On Sat, Nov 16, 2002 at 05:17:50AM -0200, Arnaldo Carvalho de Melo wrote:
> > Em Sat, Nov 16, 2002 at 02:10:13AM -0500, Gerhard Mack escreveu:
> > > On Fri, 15 Nov 2002, Larry McVoy wrote:
> >  
> > > > This is not an easy problem space, on the one hand you want to have all
> > > > bugs tracked, on the other hand, trivial bugs in the bug db just make the
> > > > bug db unusable.  No engineer is going to put up with 100,000 stupid bug
> > > > reports.  You need a plan to get rid of those or keep them out of the bugdb
> > > > or it's unlikely to get used by the people who really need to use it.
> > 
> > > Or the bugs could just be assigned to whoever owns the patchset ...
> > 
> > or the tickets could just be closed after, say, one month without activity.
> > 
> > If it is really a bug it'll be resubmitted after a while, its not as we'll not
> > have duplicates anyway...
  
> Very bad idea. People using unusual hardware do not want to keep
> re-submitting a bug report. I know when I submit a report I expect that it
> will remain until the problem is fixed. I do not like to receive multiple

Oh well, there is _no_ guarantee that it will be fixed, sometimes there is no
maintainer at all and the ticket will stay there forever lost in the noise...
And if anybody is interested in fixing the driver or even looking to see if
somebody submitted a ticket he/she can just search for all tickets, even the
ones closed because nobody is did any activity in a perior of one month (or any
other timeout period).

Its not like the ticket will vanish from the database.

- Arnaldo
