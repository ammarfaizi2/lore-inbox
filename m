Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263316AbVFYEbH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263316AbVFYEbH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 00:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263325AbVFYEbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 00:31:07 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:17549 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S263316AbVFYEbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 00:31:05 -0400
Message-ID: <42BCDE06.8080309@namesys.com>
Date: Fri, 24 Jun 2005 21:31:02 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: David Masover <ninja@slaphack.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <200506231924.j5NJOvLA031008@laptop11.inf.utfsm.cl>	 <42BB31E9.50805@slaphack.com>	 <1119570225.18655.75.camel@localhost.localdomain>	 <42BB7B32.4010100@slaphack.com> <1119612849.17063.105.camel@localhost.localdomain> <42BCCC32.1090802@slaphack.com> <42BCCCED.3030705@pobox.com>
In-Reply-To: <42BCCCED.3030705@pobox.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> Then why not listen to authorities, all of whom are saying "it's not
> ready yet"

What exactly is not ready Jeff?  As I see it, this thread is 95%
posturing, and almost no technical reasons for not merging.  These
"authorities"seem perfectly content with echoing the words of someone
who skimmed the code and shot his mouth off without understanding it,
and now these "authorities" just echo him because they like him and
assume he must be right.

Actually, David's understanding of reiser4 is far deeper than those of
anyone claiming to be an "authority".  He understands what a plugin is. 
Wow.  He does not have to be told that VFS does not currently support a
notion of pluginids, so it is not duplicative.  Wow.  He does not have
to be told that plugins are analogous to classes and what VFS currently
has is analogous to instances.  Wow.  He gets it that reiser4 plugins
disturb absolutely nothing in the rest of the kernel because we use the
standard VFS interface.  Wow.  Does any of the rest of that echo chamber
of authority understand those things?  Seems to me that these
"authorities" are just as capable of shooting their mouths off before
doing their homework as anyone else is..... 

David has used reiser4.  Have you?  Maybe you guys should try it.  Maybe
you should all have less faith in your ability to skim code and
understand it instantly.  Maybe you guys should actually read the
technical parts of this thread rather than the flame parts only?

Maybe our community's social traditions are a bit lacking?  Maybe saying
that everyone else goes through this just means that changing the way we
do things is needed even more?

Hans
