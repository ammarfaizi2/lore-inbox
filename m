Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265305AbSKNWBs>; Thu, 14 Nov 2002 17:01:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265306AbSKNWBs>; Thu, 14 Nov 2002 17:01:48 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:13067 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S265305AbSKNWBr>; Thu, 14 Nov 2002 17:01:47 -0500
Date: Thu, 14 Nov 2002 20:08:28 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: "David S. Miller" <davem@redhat.com>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Bugzilla bug tracking database for 2.5 now available.
Message-ID: <20021114220828.GH15563@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	"David S. Miller" <davem@redhat.com>,
	Jeff Garzik <jgarzik@pobox.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <225710000.1037241209@flay> <3DD3D6E1.3060104@pobox.com> <234560000.1037297061@flay> <1037304674.13735.0.camel@rth.ninka.net> <20021114201231.GE15563@conectiva.com.br> <265930000.1037314635@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <265930000.1037314635@flay>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Nov 14, 2002 at 02:57:15PM -0800, Martin J. Bligh escreveu:
> >> On Thu, 2002-11-14 at 10:04, Martin J. Bligh wrote:
> >> > > If people have net driver bugs, feel free to report them to the 
> >> > > above URL, and assign them to me...
> >> > 
> >> > You should now be the default owner for net driver bugs. Still looking
> >> > for other willing owners ;-)
> >> 
> >> Please assign the other networking categories to davem@vger.kernel.org
> >> thanks.
> > 
> > Hey boss, if you accept I can take care of the ones for
> > 
> > net/{ipx,llc,appletalk,x25,lapb}
> 
> We didn't bother breaking those out as they're .... ummm ... obscure,

OK, I guessed that perhaps the reason for creating a category was if
there was an active maintainer willing to actually look at the tickets
for these a subsystem :-)

> and I wasn't desperately keen to end up with 10,000 categories ;-)

Agreed, do it as you're doing now or as when somebody explicitely asks because
he maintains the thing and will work on respective tickets opened

> They should get dumped into "networking, other" at the moment. 

No problem

> These are just the default owners, so bugs can just get reassigned
> to somebody else if that suits ...

networking, other (or 'obscure' ;-)) can come to me, if nobody objects, I'll
reassign if needed.

Just trying to find a way to help divide the load on the triage stage 8)

- Arnaldo
