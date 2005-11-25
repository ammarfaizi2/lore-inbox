Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932065AbVKYVMo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbVKYVMo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 16:12:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbVKYVMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 16:12:44 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:20652
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1750828AbVKYVMo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 16:12:44 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [PATCH] make miniconfig (take 2)
Date: Fri, 25 Nov 2005 15:12:20 -0600
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
References: <200511170629.42389.rob@landley.net> <200511241145.24037.rob@landley.net> <Pine.LNX.4.61.0511250022330.1609@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0511250022330.1609@scrub.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511251512.20330.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 24 November 2005 19:48, Roman Zippel wrote:
> Hi,
>
> On Thu, 24 Nov 2005, Rob Landley wrote:
> > > On Mon, 21 Nov 2005, Rob Landley wrote:
> > > > Add "make miniconfig", plus documentation, plus the script that
> > > > creates a minimal mini.config from a normal .config file.
> > >
> > > The difference between miniconfig and allnoconfig is IMO too small to
> > > be really worth it right now.
> >
> > I disagree, fairly strongly.  The technical difference may be small, but
> > the conceptual difference is huge.
>
> I don't really disagree, a proper implementation of the concept would also
> be technically quite different. Hacking it into conf.c is the wrong to go
> (or to even start).

Hang on, I misread that last time.  You _don't_ disagree.

Sorry about that.

Ok, what's the best thing I can do to help get this implemented, working 
_with_ you rather than against?

Rob
-- 
Steve Ballmer: Innovation!  Inigo Montoya: You keep using that word.
I do not think it means what you think it means.
