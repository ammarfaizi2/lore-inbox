Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287008AbRL1VBA>; Fri, 28 Dec 2001 16:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287026AbRL1VAw>; Fri, 28 Dec 2001 16:00:52 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:21466
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S287008AbRL1VAp>; Fri, 28 Dec 2001 16:00:45 -0500
Date: Fri, 28 Dec 2001 15:45:37 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Legacy Fishtank <garzik@havoc.gtf.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, Dave Jones <davej@suse.de>,
        "Eric S. Raymond" <esr@snark.thyrsus.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: State of the new config & build system
Message-ID: <20011228154537.E17774@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Legacy Fishtank <garzik@havoc.gtf.org>,
	Linus Torvalds <torvalds@transmeta.com>, Dave Jones <davej@suse.de>,
	"Eric S. Raymond" <esr@snark.thyrsus.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
In-Reply-To: <20011228042648.A7943@havoc.gtf.org> <Pine.LNX.4.33.0112280948450.23339-100000@penguin.transmeta.com> <20011228154151.B27313@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011228154151.B27313@havoc.gtf.org>; from garzik@havoc.gtf.org on Fri, Dec 28, 2001 at 03:41:51PM -0500
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Legacy Fishtank <garzik@havoc.gtf.org>:
> For single-file drivers, I like Becker's (correct credit?) system...
> about 10 lines of metadata is embedded in a C comment, and it includes
> the Config.in and Configure.help info.

I proposed implementing something like this about a year ago (to
replace the nasty centralized knowledge in the MAINTAINERS and CREDITS
files) and was shot down.

I'd be happy to take another swing at this problem once the kbuild-2.5/CML2
transition is done.  But I don't think we should let it block us from
having the good results we can get from that change.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

"Those who make peaceful revolution impossible 
will make violent revolution inevitable."
	-- John F. Kennedy
