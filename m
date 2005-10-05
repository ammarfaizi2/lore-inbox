Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965228AbVJEPmm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965228AbVJEPmm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 11:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965229AbVJEPml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 11:42:41 -0400
Received: from free.hands.com ([83.142.228.128]:7853 "EHLO free.hands.com")
	by vger.kernel.org with ESMTP id S965228AbVJEPmk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 11:42:40 -0400
Date: Wed, 5 Oct 2005 16:42:26 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Marc Perkel <marc@perkel.com>, Nix <nix@esperi.org.uk>, 7eggert@gmx.de,
       linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
Message-ID: <20051005154226.GI10538@lkcl.net>
References: <4TiWy-4HQ-3@gated-at.bofh.it> <4U0XH-3Gp-39@gated-at.bofh.it> <E1EMutG-0001Hd-7U@be1.lrz> <87k6gsjalu.fsf@amaterasu.srvr.nix> <4343E611.1000901@perkel.com> <20051005152447.GD10538@lkcl.net> <20051005153006.GD8011@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051005153006.GD8011@csclub.uwaterloo.ca>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2005 at 11:30:06AM -0400, Lennart Sorensen wrote:
> On Wed, Oct 05, 2005 at 04:24:47PM +0100, Luke Kenneth Casson Leighton wrote:
> >   ahh, *sigh*, i remember the days.
> > 
> >   in 1989 i looked in /tmp on our sunos 4.1.3 server at
> >   imperial, which was running a bit slow, went "eek, that's
> >   a lot of files in /tmp" and did am rm -fr /tmp.
> 
> Why would /tmp allow you to delete files there you didn't own unless you
> were root?  

 i have no idea.  as a user, i just did rm -fr /tmp/* (sorry - not
 rm -fr /tmp) and it worked.

 as a user.

 not root.

> >   a few minutes later the sysadmins quite literally stormed in.
> 
> And promptly removed root access from the person that wasn't qualified
> to have it in the first place? :)
 
 they weren't dumb enough to give it to me.

> >   apparently the printer queue temp files were stored in /tmp and 100
> >   third year students were all trying to print out their course-work,
> >   last minute.
> > 
> And why would the printer queue use /tmp in the first place?
 
 ahh, that would answer the implicit question as to why they
 jumped up and down at me rather than frog-marched me off campus.

> >   oops.
> > 
> >   yes, imperial college third year theory of computing students of
> >   1987-1990, it was me.
> 
> Did they ever let you have root again?

 i was a student there.  they didn't let _anyone_ like me have root.
 
 someone got into trouble for even demonstrating a security
 vulnerability.

 l.
