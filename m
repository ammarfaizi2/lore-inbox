Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270942AbRHXE6Q>; Fri, 24 Aug 2001 00:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270947AbRHXE6G>; Fri, 24 Aug 2001 00:58:06 -0400
Received: from UNASSIGNED.SKYNETWEB.COM ([64.23.55.10]:5914 "HELO
	mx.webmailstation.com") by vger.kernel.org with SMTP
	id <S270942AbRHXE57> convert rfc822-to-8bit; Fri, 24 Aug 2001 00:57:59 -0400
Content-Type: text/plain; charset=US-ASCII
From: Denis Perchine <dyp@perchine.com>
Organization: AcademSoft
To: linux-kernel@vger.kernel.org
Subject: Re: Will 2.6 require Python for any configuration ? (CML2)
Date: Fri, 24 Aug 2001 11:59:41 +0700
X-Mailer: KMail [version 1.3.5]
In-Reply-To: <20010822030807.N120@pervalidus> <d3k7zutw5y.fsf@lxplus051.cern.ch> <20010823124109.S14302@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <20010823124109.S14302@cpe-24-221-152-185.az.sprintbbd.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010824020119.42D951FD7D@mx.webmailstation.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 August 2001 02:41, Tom Rini wrote:
> On Thu, Aug 23, 2001 at 09:26:33PM +0200, Jes Sorensen wrote:
> > >>>>> "Tom" == Tom Rini <trini@kernel.crashing.org> writes:
> You've said this before. :)  Just how small of an 'embedded' system are
> you talking about?  I know of people who do compile a kernel now and
> again on a 'small' system, for fun.  On a larger (cPCI) system, I
> don't see your point.  If you can somehow transport the 21mb[1] bzip2
> kernel source to your system, you can transport python.  If you're
> porting to a brand new arch, there's still good tests before you
> have shlib support (You've mentioned that before too I think).

There is another point why having Python installed is a problem. Usually when 
you install a server you remove everything from it because of space, and 
security reasons. The main security concern is the less is installed the 
better security is. I always remove python from any servers I have. As I 
remove guile, forth, and other useless (in terms of server) languages. Now 
you tell me that I should have this bloat installed just to configure my 
kernel. Do not you think that it is too much? Current kernel does not require 
anything like this.

-- 
Sincerely Yours,
Denis Perchine

----------------------------------
E-Mail: dyp@perchine.com
HomePage: http://www.perchine.com/dyp/
FidoNet: 2:5000/120.5
----------------------------------
