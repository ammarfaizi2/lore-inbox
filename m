Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290508AbSAYIOb>; Fri, 25 Jan 2002 03:14:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290599AbSAYIOV>; Fri, 25 Jan 2002 03:14:21 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:17672 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S290508AbSAYIOT>; Fri, 25 Jan 2002 03:14:19 -0500
Message-ID: <3C511249.2DFE6CCF@zip.com.au>
Date: Fri, 25 Jan 2002 00:07:37 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Giacomo Catenazzi <cate@debian.org>
CC: Sam Ravnborg <sam@ravnborg.org>, Anuradha Ratnaweera <anuradha@gnu.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] kernelconf-0.1.2
In-Reply-To: <fa.fntpj9v.103mb83@ifi.uio.no> <fa.h5to74v.132gv1k@ifi.uio.no> <3C511163.7030500@debian.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giacomo Catenazzi wrote:
> 
> Sam Ravnborg wrote:
> 
> > On Thu, Jan 24, 2002 at 12:45:48PM +0600, Anuradha Ratnaweera wrote:
> >
> >>Here we go again...
> >>
> >>Version 0.1.2 is an RFC.  Don't use it unless you are really adventurous.
> >>The size of the tarball has grown by a factor of 6, mostly due to the
> >>symbol files.
> >>
> >
> > Hi Anuradha.
> > I have not looked into the SRC, but IIRC you mentioned an interest in LEX/YACC for CML2.
> > Take a look at:
> > http://www.alphalink.com.au/~gnb/cml2
> >
> > This is an incomplete implementation of a CML2 parser + semantic analysis in C utilising a bison parser.
> 
> Hmm. This is the 3rd C cml2 implementation I have heard. (+ non CML2 based Kernelconfig).
> 
> People, don't waste the time! Please merge the projects (They will be only one).
> 

I took the time to download and look at Anuradha's work yesterday.
It seems nice, sensible and sane.  I suspect it would have saved
Linus many hours work.

-
