Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291132AbSAaQMy>; Thu, 31 Jan 2002 11:12:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291128AbSAaQMo>; Thu, 31 Jan 2002 11:12:44 -0500
Received: from ns1.intercarve.net ([216.254.127.221]:51460 "HELO
	ceramicfrog.intercarve.net") by vger.kernel.org with SMTP
	id <S291127AbSAaQM3>; Thu, 31 Jan 2002 11:12:29 -0500
Date: Thu, 31 Jan 2002 11:09:41 -0500 (EST)
From: "Drew P. Vogel" <dvogel@intercarve.net>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Dave Jones <davej@suse.de>, <linux-kernel@vger.kernel.org>,
        <patchbot-devel@killeri.net>
Subject: Re: Public patch penguin
In-Reply-To: <E16W7xt-0000KX-00@starship.berlin>
Message-ID: <Pine.LNX.4.33.0201311103450.15627-100000@northface.intercarve.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Agreed.  Please have a look at what we're doing here:
>
>   http://killeri.net/cgi-bin/alias/ezmlm-cgi
>
>It's too early to try the code, currently at version 0.0 (thanks to Rasmus
>Andersen for that, Kalle Kivimaa for the mail list).  The guilding design
>rule is to do everything with MTAs that submitters and maintainers _are
>already using_, and to do it _just as they do it now_, using a normal mail
>archive as the data base.  The only thing that changes is: you mail the
>patchbot instead of the maintainer.
>
>Submitters will need to put some minimal number of additional lines in the
>body of the email, and it's possible we'll get the 'minimal number' down to
>zero for common cases (one line description comes from subject, long
>description comes from mail, purpose is implied by [BUGFIX] in subject line,
>etc).
>
>Do you see anything to object to so far?

Well, I don't have any objections, per se. What I did notice immediately
though is that the web browser is still involved. My *ideal*
implementation would be very similar. The only significant difference
would be that the patches would be sorted into directories, in a public
ftp archive. The special comments would be display while changing
directories in the archive. This way I can at least just type 'lynx
ftp://kernel.patches.archive/patch_name/' and the first entry is the most
current patch, and the special comments from the author would be displayed
at the top.

--Drew Vogel


