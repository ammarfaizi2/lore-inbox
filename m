Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318926AbSH1WmB>; Wed, 28 Aug 2002 18:42:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319015AbSH1WmB>; Wed, 28 Aug 2002 18:42:01 -0400
Received: from air-2.osdl.org ([65.172.181.6]:36484 "EHLO
	wookie-t23.pdx.osdl.net") by vger.kernel.org with ESMTP
	id <S318926AbSH1WmA>; Wed, 28 Aug 2002 18:42:00 -0400
Subject: Re: [Lse-tech] Re: [patch] SImple Topology API v0.3 (1/2)
From: "Timothy D. Witham" <wookie@osdl.org>
To: Thunder from the hill <thunder@lightweight.ods.org>
Cc: Pavel Machek <pavel@suse.cz>, Matthew Dobson <colpatch@us.ibm.com>,
       Andrew Morton <akpm@zip.com.au>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Martin Bligh <mjbligh@us.ibm.com>,
       Andrea Arcangeli <andrea@suse.de>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>,
       lse-tech <lse-tech@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0208281640240.3234-100000@hawkeye.luckynet.adm>
References: <Pine.LNX.4.44.0208281640240.3234-100000@hawkeye.luckynet.adm>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 28 Aug 2002 15:42:09 -0700
Message-Id: <1030574529.6157.132.camel@wookie-t23.pdx.osdl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  I don't think that it really matters the only thing
that I was thinking of is that you might have 
a case in the future where you would like to break out
some of the stuff into say ... PPC or SPARC NUMA and also
X86 NUMA but still keep the Cache Coherent NUMA configuration
as a base.  But that is just wild talk from somebody
who knows wild talk. :-)

Tim

On Wed, 2002-08-28 at 15:40, Thunder from the hill wrote:
> Hi,
> 
> On 28 Aug 2002, Timothy D. Witham wrote:
> > How about the old Marketing name CONFIG_CCNUMA?
> 
> Why not keep CONFIG_X86_NUMA then?
> 
> 			Thunder
> -- 
> --./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
> --/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
> .- -/---/--/---/.-./.-./---/.--/.-.-.-
> --./.-/-.../.-./.././.-../.-.-.-
-- 
Timothy D. Witham - Lab Director - wookie@osdlab.org
Open Source Development Lab Inc - A non-profit corporation
15275 SW Koll Parkway - Suite H - Beaverton OR, 97006
(503)-626-2455 x11 (office)    (503)-702-2871     (cell)
(503)-626-2436     (fax)

