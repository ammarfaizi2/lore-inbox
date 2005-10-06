Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751361AbVJFVUK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbVJFVUK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 17:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbVJFVUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 17:20:10 -0400
Received: from free.hands.com ([83.142.228.128]:11224 "EHLO free.hands.com")
	by vger.kernel.org with ESMTP id S1751361AbVJFVUI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 17:20:08 -0400
Date: Thu, 6 Oct 2005 22:20:01 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Michael Concannon <mike@concannon.net>
Cc: Chase Venters <chase.venters@clientec.com>, Marc Perkel <marc@perkel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
Message-ID: <20051006212001.GZ10538@lkcl.net>
References: <20051002204703.GG6290@lkcl.net> <200510041840.55820.chase.venters@clientec.com> <20051005102650.GO10538@lkcl.net> <200510060005.09121.chase.venters@clientec.com> <43453E7F.5030801@concannon.net> <20051006192857.GV10538@lkcl.net> <4345855B.3@concannon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4345855B.3@concannon.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2005 at 04:13:15PM -0400, Michael Concannon wrote:

> 1. It _is_ a file: registry.dat
> 2. It is a binary file at that...
> 3. That file has become a dumping ground for everything that every app 
> thinks is "important" and of course every app writer thinks everything 
> they write is the most important thing ever - I am sure a have never 
> done such a thing :-)
 
 s/"that file"/"openldap" and substitute "every app writer"
 for "every major free software developer we respect greatly which
 can store its data and/or configuration details in an LDAP database"
 and your evident distaste for "that file" looks a little like religious
 zealotry.

 i say that with the greatest respect.

 especially when "that file" is actually a database, just like
 Berkeley DB (and we all know and _love_ Berkeley DB).

 and especially in light it being possible to do a "decent" job, and
 make "that file" available via a POSIX filesystem interface.

 l.

> I guess you could argue that #3 is the fault of the app writers and not 
> the architecture, 

 yes.  i would say it's more to do with the dumb-ass nature of the app
 writers, yes.  typicall dumb-ass windows app writers give a shit about
 security and care greatly about making money hand-over-fist.
 
 whereas on linux it's far less likely for an app writer to
 be able to get away with a) making money b) friggin up security.  the
 distros wouldn't allow an app writer to get away with either.

 l.


