Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286654AbRL1BgW>; Thu, 27 Dec 2001 20:36:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286653AbRL1BgO>; Thu, 27 Dec 2001 20:36:14 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:54278 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S286649AbRL1BgD>;
	Thu, 27 Dec 2001 20:36:03 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Larry McVoy <lm@bitmover.com>
Cc: "Eric S. Raymond" <esr@thyrsus.com>, Dave Jones <davej@suse.de>,
        "Eric S. Raymond" <esr@snark.thyrsus.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: State of the new config & build system 
In-Reply-To: Your message of "Thu, 27 Dec 2001 17:15:45 -0800."
             <20011227171545.T25698@work.bitmover.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 28 Dec 2001 12:35:50 +1100
Message-ID: <18619.1009503350@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Dec 2001 17:15:45 -0800, 
Larry McVoy <lm@bitmover.com> wrote:
>[talking about kbuild 2.5 speed]
>Then it does seem reasonable to ask that the new one is at least as fast
>as the old one.

kbuild 2.4 is fast but inaccurate, kbuild 2.5 is slower but accurate.
Pick one.

I am sure that I can speed up kbuild 2.5 with a rewrite of the core
code but I am staying on stable code to send to Linus.

