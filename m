Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270206AbRHXHLx>; Fri, 24 Aug 2001 03:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270178AbRHXHLn>; Fri, 24 Aug 2001 03:11:43 -0400
Received: from UNASSIGNED.SKYNETWEB.COM ([64.23.55.10]:41780 "HELO
	mx.webmailstation.com") by vger.kernel.org with SMTP
	id <S269974AbRHXHLj> convert rfc822-to-8bit; Fri, 24 Aug 2001 03:11:39 -0400
Content-Type: text/plain; charset=US-ASCII
From: Denis Perchine <dyp@perchine.com>
Organization: AcademSoft
To: linux-kernel@vger.kernel.org
Subject: Re: Will 2.6 require Python for any configuration ? (CML2)
Date: Fri, 24 Aug 2001 14:13:29 +0700
X-Mailer: KMail [version 1.3.5]
In-Reply-To: <20010822030807.N120@pervalidus> <20010824020119.42D951FD7D@mx.webmailstation.com> <20010824093508.A17415@francoudi.com>
In-Reply-To: <20010824093508.A17415@francoudi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010824041500.BBE381FD71@mx.webmailstation.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 August 2001 13:35, Leonid Mamtchenkov wrote:
> Once you wrote about "Re: Will 2.6 require Python for any configuration ?
> (CML2)": DP> On Friday 24 August 2001 02:41, Tom Rini wrote:
> DP> > On Thu, Aug 23, 2001 at 09:26:33PM +0200, Jes Sorensen wrote:
> DP> > > >>>>> "Tom" == Tom Rini <trini@kernel.crashing.org> writes:
> DP> > You've said this before. :)  Just how small of an 'embedded' system are
> DP> > you talking about?  I know of people who do compile a kernel now and
> DP> > again on a 'small' system, for fun.  On a larger (cPCI) system, I
> DP> > don't see your point.  If you can somehow transport the 21mb[1] bzip2
> DP> > kernel source to your system, you can transport python.  If you're
> DP> > porting to a brand new arch, there's still good tests before you
> DP> > have shlib support (You've mentioned that before too I think).
> DP> There is another point why having Python installed is a problem. Usually when
> DP> you install a server you remove everything from it because of space, and
> DP> security reasons. The main security concern is the less is installed the
> DP> better security is. I always remove python from any servers I have. As I
> DP> remove guile, forth, and other useless (in terms of server) languages. Now
> DP> you tell me that I should have this bloat installed just to configure my
> DP> kernel. Do not you think that it is too much? Current kernel does not require
> DP> anything like this.

> Why should you have gcc and make on the server then?  Compile you kernel
> on another machine and then just install it on your servers.  This way
> you will not only save space and improve security, but also gain some
> time, which is always good.

That's nice idea, but it does not have any connection to subj.
I prefer to do things the way I do them now. Anyway I need compiler for other things.
I have lot of C/C++ daemons running, and want to fix problems right there.
But having Python just to configure a kernel is an overkill. Why not Sather, or other rarely used language.
Oberon-2 would be also nice.

This is just a laziness of people who do not want to make things right. Actually interesting question
is what Linus think of all this crap?

-- 
Sincerely Yours,
Denis Perchine

----------------------------------
E-Mail: dyp@perchine.com
HomePage: http://www.perchine.com/dyp/
FidoNet: 2:5000/120.5
----------------------------------
