Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313711AbSHTGr6>; Tue, 20 Aug 2002 02:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315285AbSHTGr6>; Tue, 20 Aug 2002 02:47:58 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:27142 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S313711AbSHTGr6>; Tue, 20 Aug 2002 02:47:58 -0400
Date: Mon, 19 Aug 2002 23:51:59 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.31 driverfs: patch for your consideration
Message-ID: <20020820065159.GD28996@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0208191111100.1048-100000@cherise.pdx.osdl.net> <3D6113E1.302@netscape.net> <20020819195909.GA24488@kroah.com> <3D61691B.7080409@netscape.net> <20020820033254.GA26331@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020820033254.GA26331@kroah.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2002 at 08:32:55PM -0700, Greg KH wrote:
> On Mon, Aug 19, 2002 at 09:54:35PM +0000, Adam Belay wrote:
> > By the way, is diethotplug a space efficient binary version of the
> > hotplug scripts or is there more to it then that?
> 
> Yes it is a space efficient version (the resulting binary is usually
> 300% smaller than the original modules.*map files being used.)  It
> achieves these space savings at the expense of flexibility, the binary
> is always tied to a specific kernel version.

My apologies if you meant 30%

<rant>

Arrgh!  Please explain the math.  How can something be more
than 100% smaller than something else.

I know it is OT but this marketing math really bugs me.
i've yet to see anyone explain how y = x - (3x) where x < 0
and y <= 0 can yield a positive number without first proving
-1 == 1.

</rant>


-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
