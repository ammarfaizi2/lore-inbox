Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292212AbSBOWNl>; Fri, 15 Feb 2002 17:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292215AbSBOWNc>; Fri, 15 Feb 2002 17:13:32 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:19
	"EHLO golux.thyrsus.com") by vger.kernel.org with ESMTP
	id <S292212AbSBOWNP>; Fri, 15 Feb 2002 17:13:15 -0500
Date: Fri, 15 Feb 2002 16:46:10 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dave Jones <davej@suse.de>,
        Arjan van de Ven <arjan@pc1-camc5-0-cust78.cam.cable.ntl.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Disgusted with kbuild developers
Message-ID: <20020215164610.A14418@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Jones <davej@suse.de>,
	Arjan van de Ven <arjan@pc1-camc5-0-cust78.cam.cable.ntl.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020215155946.B14083@thyrsus.com> <E16bqC7-0004Mj-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E16bqC7-0004Mj-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Feb 15, 2002 at 09:47:03PM +0000
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk>:
> The prototype generates a very convincing table set, and the tables generate
> very convincing graphs. The information to work out what option needs another
> as I've said for months

I've *solved* this problem.  I understand the constraints.  I know 
exactly what you will have to do to get the rest of the way, *because
I did it*.

I have built not just a "proof of concept" but a working
implementation so robust that it is in production use by three
different projects.  And a substantial number of kernel developers are
using it now and reporting it good.

The good thing about working with developers like you and Dave Jones
and many of the other loonies on this list is that you are fucking
brilliant.  The bad thing is that because you're fucking brilliant,
you're often also ungodly arrogant about second-guessing other
peoples' work -- you think your snap judgment or "proof of concept" is
somehow equivalent to two years of design, coding and testing by
someone who has been concentrating on the problem.

News bulletin: IT'S NOT.

Alan, don't talk to me about "proof of concept".  Tell me about a
production-quality system, proven in use by people like Embedsys,
Webmachines, and the Compache project.  Tell me you can duplicate what
CML2 does successfully before you run around implying my design
assumptions are full of crap.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>
