Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265246AbSKNV4V>; Thu, 14 Nov 2002 16:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265262AbSKNV4V>; Thu, 14 Nov 2002 16:56:21 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:14839 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265246AbSKNV4U>;
	Thu, 14 Nov 2002 16:56:20 -0500
Date: Thu, 14 Nov 2002 14:57:15 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       "David S. Miller" <davem@redhat.com>
cc: Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Bugzilla bug tracking database for 2.5 now available.
Message-ID: <265930000.1037314635@flay>
In-Reply-To: <20021114201231.GE15563@conectiva.com.br>
References: <225710000.1037241209@flay> <3DD3D6E1.3060104@pobox.com> <234560000.1037297061@flay> <1037304674.13735.0.camel@rth.ninka.net> <20021114201231.GE15563@conectiva.com.br>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> On Thu, 2002-11-14 at 10:04, Martin J. Bligh wrote:
>> > > If people have net driver bugs, feel free to report them to the 
>> > > above URL, and assign them to me...
>> > 
>> > You should now be the default owner for net driver bugs. Still looking
>> > for other willing owners ;-)
>> 
>> Please assign the other networking categories to davem@vger.kernel.org
>> thanks.
> 
> Hey boss, if you accept I can take care of the ones for
> 
> net/{ipx,llc,appletalk,x25,lapb}

We didn't bother breaking those out as they're .... ummm ... obscure,
and I wasn't desperately keen to end up with 10,000 categories ;-)
They should get dumped into "networking, other" at the moment. 
These are just the default owners, so bugs can just get reassigned
to somebody else if that suits ...

M.

