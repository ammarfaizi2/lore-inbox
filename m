Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132806AbRECQEd>; Thu, 3 May 2001 12:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132895AbRECQEX>; Thu, 3 May 2001 12:04:23 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:46344 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S132806AbRECQEM>;
	Thu, 3 May 2001 12:04:12 -0400
Date: Thu, 3 May 2001 12:04:16 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: John Stoffel <stoffel@casc.com>, cate@dplanet.ch,
        CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: Requirement of make oldconfig [was: Re: [kbuild-devel] Re: CML2 1.3.1, aka ...]
Message-ID: <20010503120416.H31960@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Horst von Brand <vonbrand@inf.utfsm.cl>,
	John Stoffel <stoffel@casc.com>, cate@dplanet.ch,
	CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <stoffel@casc.com> <200105031232.f43CW7aA009990@pincoya.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200105031232.f43CW7aA009990@pincoya.inf.utfsm.cl>; from vonbrand@inf.utfsm.cl on Thu, May 03, 2001 at 08:32:07AM -0400
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand <vonbrand@inf.utfsm.cl>:
> If you support broken configurations in any way, your program is just
> wildly guessing what they did mean. The exact (and very probably not in any
> way cleanly thought out) behaviour in corner cases then becomes "the way
> things work", and we end up in an unmaintainable mess yet again.

Yes, this is precisely what I fear.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Rapists just *love* unarmed women.  And the politicians who disarm them.
