Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284497AbRL1VVr>; Fri, 28 Dec 2001 16:21:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284506AbRL1VVh>; Fri, 28 Dec 2001 16:21:37 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:39095 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S284497AbRL1VVY>;
	Fri, 28 Dec 2001 16:21:24 -0500
Date: Fri, 28 Dec 2001 16:19:34 -0500
From: Legacy Fishtank <garzik@havoc.gtf.org>
To: "Eric S. Raymond" <esr@thyrsus.com>,
        Linus Torvalds <torvalds@transmeta.com>, Dave Jones <davej@suse.de>,
        "Eric S. Raymond" <esr@snark.thyrsus.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: State of the new config & build system
Message-ID: <20011228161934.C5397@havoc.gtf.org>
In-Reply-To: <20011228042648.A7943@havoc.gtf.org> <Pine.LNX.4.33.0112280948450.23339-100000@penguin.transmeta.com> <20011228154151.B27313@havoc.gtf.org> <20011228154537.E17774@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011228154537.E17774@thyrsus.com>; from esr@thyrsus.com on Fri, Dec 28, 2001 at 03:45:37PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2001 at 03:45:37PM -0500, Eric S. Raymond wrote:
> Legacy Fishtank <garzik@havoc.gtf.org>:
> > For single-file drivers, I like Becker's (correct credit?) system...
> > about 10 lines of metadata is embedded in a C comment, and it includes
> > the Config.in and Configure.help info.
> 
> I proposed implementing something like this about a year ago (to
> replace the nasty centralized knowledge in the MAINTAINERS and CREDITS
> files) and was shot down.

Note I am specifically NOT talking about MAINTAINERS and CREDITS.
-PLEASE- don't obscure my point by mentioning them.

Dealing with MAINTAINERS and CREDITS in an automated fashion seems more
like pointless masturbation to me.  If you want to find out who needs to
be CC'd on patches, use your brain like I do.

	Jeff


