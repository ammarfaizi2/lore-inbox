Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313477AbSDUPxe>; Sun, 21 Apr 2002 11:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313480AbSDUPxd>; Sun, 21 Apr 2002 11:53:33 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:6152 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S313477AbSDUPxc>;
	Sun, 21 Apr 2002 11:53:32 -0400
Date: Sun, 21 Apr 2002 12:53:22 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Jochen Friedrich <jochen@scram.de>
Cc: Ian Molton <spyro@armlinux.org>, Russell King <rmk@arm.linux.org.uk>,
        <phillips@bonn-fries.net>, <ebiederm@xmission.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove Bitkeeper documentation from Linux tree
Message-ID: <20020421155322.GA3958@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Jochen Friedrich <jochen@scram.de>, Ian Molton <spyro@armlinux.org>,
	Russell King <rmk@arm.linux.org.uk>, <phillips@bonn-fries.net>,
	<ebiederm@xmission.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20020421025654.GE2296@conectiva.com.br> <Pine.LNX.4.44.0204211123590.18496-100000@alpha.bocc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Apr 21, 2002 at 11:28:36AM +0200, Jochen Friedrich escreveu:
> > > We dont allow proprietary modules in the kernel, why should docs be any
> > > different?
> > 
> > The documentation being discussed is not proprietary, it only talks about a non
> > essential proprietary tool used now by lots of kernel hackers.
> 
> So would Linus accept a document on how to run Linux/390 on hercules (yet 
> another proprietary emulator)? This also was a FAQ on the linux-390 

Don't know, tried to submit?

Just checked, Hercules is not a proprietary emulator, in fact it is licensed
under the QPL. http://www.conmicro.cx/hercules/herclic.html

> mailing list until the documentation is available on the hercules home 
> page...

> Developing kernel stuff on 390 without emulator can be much fun as host 
> operators tend to get very pissed if the IPL ratio comes near to 1/min ;-)

<joke>
Another good question: does Linus cares about Linux S/390? ;)
</joke>

- Arnaldo
