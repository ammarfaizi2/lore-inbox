Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267380AbSKPVxw>; Sat, 16 Nov 2002 16:53:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267381AbSKPVxw>; Sat, 16 Nov 2002 16:53:52 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:14858 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S267380AbSKPVxu>; Sat, 16 Nov 2002 16:53:50 -0500
Date: Sat, 16 Nov 2002 20:00:38 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
Subject: Re: Bugzilla bug tracking database for 2.5 now available.
Message-ID: <20021116220038.GC26275@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Jeff Garzik <jgarzik@pobox.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
References: <20021116214140.GP24641@conectiva.com.br> <551278547.1037454258@[10.10.2.3]> <3DD6BEB2.203@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DD6BEB2.203@pobox.com>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Nov 16, 2002 at 04:54:58PM -0500, Jeff Garzik escreveu:
> Martin J. Bligh wrote:

> >One thing we've done before in other bug-tracking systems was to create
> >a "STALE" state (or something similar) for this type of bug. So it
> >wouldn't get closed (I have seen this done as a closing resolution, but
> >I think that's a bad idea), but it wouldn't be in the default searches
> >either ... you could just select it if you wanted it ... does that sound
> >sane? (obviously we don't need this yet, but might be a good plan
> >longer-term).
 
> Personally...  if they really are bugs, I would rather keep them open, 
> even in the absence of a maintainer...   maybe that's not scalable, but 
> I would rather not auto-expire things which really are bugs.  The 
> maintainer (or "someone who cares") may not appear until the next stable 
> series, for example.  Vendors do that alot.

Jeff, ok, so we could do as vendors: mark the ticket as LATER, or whatever
that doesnt make clearly stale tickets that nobody is looking appear on
the default queries.

If somebody is _so_ interested in a particular feature he/she can look for
tickets marked LATER, add comments and state that he/she is working on it,
provide more info, etc.
 
> 'stale' may be a decent compromise if people disagree with my logic, 
> though...

:-)

- Arnaldo
