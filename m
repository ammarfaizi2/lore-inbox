Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269739AbRHXGpk>; Fri, 24 Aug 2001 02:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269962AbRHXGpa>; Fri, 24 Aug 2001 02:45:30 -0400
Received: from [217.27.32.7] ([217.27.32.7]:60525 "EHLO leonid.francoudi.com")
	by vger.kernel.org with ESMTP id <S269739AbRHXGpS>;
	Fri, 24 Aug 2001 02:45:18 -0400
Date: Fri, 24 Aug 2001 09:35:08 +0300
From: Leonid Mamtchenkov <leonid@francoudi.com>
To: Denis Perchine <dyp@perchine.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Will 2.6 require Python for any configuration ? (CML2)
Message-ID: <20010824093508.A17415@francoudi.com>
Mail-Followup-To: Denis Perchine <dyp@perchine.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010822030807.N120@pervalidus> <d3k7zutw5y.fsf@lxplus051.cern.ch> <20010823124109.S14302@cpe-24-221-152-185.az.sprintbbd.net> <20010824020119.42D951FD7D@mx.webmailstation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010824020119.42D951FD7D@mx.webmailstation.com>; from dyp@perchine.com on Fri, Aug 24, 2001 at 11:59:41AM +0700
X-Operating-System: Linux leonid.francoudi.com 2.4.9
X-Uptime: 9:09am  up 15:15,  3 users,  load average: 1.10, 1.04, 1.01
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Denis Perchine,

Once you wrote about "Re: Will 2.6 require Python for any configuration ? (CML2)":
DP> On Friday 24 August 2001 02:41, Tom Rini wrote:
DP> > On Thu, Aug 23, 2001 at 09:26:33PM +0200, Jes Sorensen wrote:
DP> > > >>>>> "Tom" == Tom Rini <trini@kernel.crashing.org> writes:
DP> > You've said this before. :)  Just how small of an 'embedded' system are
DP> > you talking about?  I know of people who do compile a kernel now and
DP> > again on a 'small' system, for fun.  On a larger (cPCI) system, I
DP> > don't see your point.  If you can somehow transport the 21mb[1] bzip2
DP> > kernel source to your system, you can transport python.  If you're
DP> > porting to a brand new arch, there's still good tests before you
DP> > have shlib support (You've mentioned that before too I think).
DP> 
DP> There is another point why having Python installed is a problem. Usually when 
DP> you install a server you remove everything from it because of space, and 
DP> security reasons. The main security concern is the less is installed the 
DP> better security is. I always remove python from any servers I have. As I 
DP> remove guile, forth, and other useless (in terms of server) languages. Now 
DP> you tell me that I should have this bloat installed just to configure my 
DP> kernel. Do not you think that it is too much? Current kernel does not require 
DP> anything like this.

Why should you have gcc and make on the server then?  Compile you kernel
on another machine and then just install it on your servers.  This way
you will not only save space and improve security, but also gain some
time, which is always good.

-- 
 Best regards,
 Leonid Mamtchenkov
 Red Hat Certified Linux Engineer (RHCE)
 System Administrator
 Francoudi & Stephanou Ltd

