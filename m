Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268490AbTCFWh5>; Thu, 6 Mar 2003 17:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268492AbTCFWh5>; Thu, 6 Mar 2003 17:37:57 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:29067 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S268490AbTCFWhz>; Thu, 6 Mar 2003 17:37:55 -0500
Date: Thu, 6 Mar 2003 23:48:12 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: John Bradford <john@grabjohn.com>
Cc: Marc-Christian Petersen <m.c.p@wolk-project.de>, mike@aiinc.ca,
       linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: re: [PATCH] Fix breakage caused by spelling 'fix'
Message-ID: <20030306224812.GB14525@louise.pinerecords.com>
References: <200303062259.20480.m.c.p@wolk-project.de> <200303062228.h26MSYYj000170@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303062228.h26MSYYj000170@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [john@grabjohn.com]
> 
> > > This fixes a spelling "fix" that resulted in a compile error.
> > > With apologies to Russell King.
> > > diff -ur a/include/asm-arm/proc-fns.h b/include/asm-arm/proc-fns.h
> > > --- a/include/asm-arm/proc-fns.h	Tue Mar  4 19:29:20 2003
> > > +++ b/include/asm-arm/proc-fns.h	Thu Mar  6 11:46:15 2003
> > > @@ -125,7 +125,7 @@
> > >
> > >  #if 0
> > >   * The following is to fool mkdep into generating the correct
> > > - * dependencies.  Without this, it can't figure out that this
> > > + * dependencies.  Without this, it cant figure out that this
> > A spelling fix should be a right spelling fix ;)
> > 
> > So either "cannot" or "can not" but not "cant" :)
> 
> "Can not" is technically wrong.

While "can not" is not necessarily bad English, it's uncommon
and should probably be avoided, because its use might produce
sentences ambivalent in meaning.

<quote>
Can/could: modal auxiliary verbs --
...
h/	contracted negative forms are "can't" and "couldn't."
	Cannot is usually written as one word.
</quote>
Swan, Michael: Practical English Usage
Oxford University Press, Second Edition, 1995
p. 104, item 122


-- 
Tomas Szepe <szepe@pinerecords.com>
