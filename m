Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284601AbRL2Q3K>; Sat, 29 Dec 2001 11:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284876AbRL2Q3B>; Sat, 29 Dec 2001 11:29:01 -0500
Received: from bitmover.com ([192.132.92.2]:2471 "EHLO bitmover.bitmover.com")
	by vger.kernel.org with ESMTP id <S284601AbRL2Q2m>;
	Sat, 29 Dec 2001 11:28:42 -0500
Date: Sat, 29 Dec 2001 08:28:38 -0800
From: Larry McVoy <lm@bitmover.com>
To: Anton Blanchard <anton@samba.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Larry McVoy <lm@bitmover.com>,
        Keith Owens <kaos@ocs.com.au>, "Eric S. Raymond" <esr@thyrsus.com>,
        Dave Jones <davej@suse.de>, "Eric S. Raymond" <esr@snark.thyrsus.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: State of the new config & build system
Message-ID: <20011229082838.A16667@work.bitmover.com>
Mail-Followup-To: Anton Blanchard <anton@samba.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Larry McVoy <lm@bitmover.com>,
	Keith Owens <kaos@ocs.com.au>, "Eric S. Raymond" <esr@thyrsus.com>,
	Dave Jones <davej@suse.de>,
	"Eric S. Raymond" <esr@snark.thyrsus.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
In-Reply-To: <20011227180148.A3727@work.bitmover.com> <E16JxmP-0000Yo-00@the-village.bc.nu> <20011228094318.B3727@work.bitmover.com> <20011229092437.GA1295@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20011229092437.GA1295@krispykreme>; from anton@samba.org on Sat, Dec 29, 2001 at 08:24:37PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 29, 2001 at 08:24:37PM +1100, Anton Blanchard wrote:
> How large is your core db stuff? The thing I like about tdb is that it
> is very simple, only recently growing over 1024 lines.

   1404    4736   32921 mdbm.c

-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
