Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131323AbREHJov>; Tue, 8 May 2001 05:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131386AbREHJom>; Tue, 8 May 2001 05:44:42 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:63500 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S131323AbREHJoa>;
	Tue, 8 May 2001 05:44:30 -0400
Date: Tue, 8 May 2001 05:44:32 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tom Rini <trini@kernel.crashing.org>, CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: CML2 design philosophy heads-up
Message-ID: <20010508054432.A16487@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Tom Rini <trini@kernel.crashing.org>,
	CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010507105950.A771@opus.bloom.county> <E14wt0Q-00048P-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14wt0Q-00048P-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, May 07, 2001 at 10:57:23PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk>:
> There are also a lot of config options that are implied by your setup in
> an embedded enviromment but which you dont actually want because you didnt
> wire them

Well, then, you don't specify the guard capability!  If your MV147 isn't 
wired for serial, then leave SERIAL off.  The point of the derivation 
is exactly to let you do that.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Sometimes the law defends plunder and participates in it. Sometimes
the law places the whole apparatus of judges, police, prisons and
gendarmes at the service of the plunderers, and treats the victim --
when he defends himself -- as a criminal.
	-- Frederic Bastiat, "The Law"
