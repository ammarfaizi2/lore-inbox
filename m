Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262497AbTFJNxI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 09:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262771AbTFJNxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 09:53:08 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:63360
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S262497AbTFJNxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 09:53:06 -0400
Date: Tue, 10 Jun 2003 09:51:34 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Stephan von Krawczynski <skraw@ithnet.com>
cc: linux-kernel@vger.kernel.org, "" <willy@w.ods.org>, "" <gibbs@scsiguy.com>,
       "" <marcelo@conectiva.com.br>, "" <green@namesys.com>
Subject: Re: Undo aic7xxx changes (now rc7+aic20030603)
In-Reply-To: <20030610153815.57f7a563.skraw@ithnet.com>
Message-ID: <Pine.LNX.4.50.0306100949040.19137-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.55L.0305071716050.17793@freak.distro.conectiva>
 <2804790000.1052441142@aslan.scsiguy.com> <20030509120648.1e0af0c8.skraw@ithnet.com>
 <20030509120659.GA15754@alpha.home.local> <20030509150207.3ff9cd64.skraw@ithnet.com>
 <20030605181423.GA17277@alpha.home.local> <20030608131901.7cadf9ea.skraw@ithnet.com>
 <20030608134901.363ebe42.skraw@ithnet.com> <20030609171011.7f940545.skraw@ithnet.com>
 <Pine.LNX.4.50.0306092135000.19137-100000@montezuma.mastecende.com>
 <20030610123015.4242716e.skraw@ithnet.com>
 <Pine.LNX.4.50.0306100847580.19137-100000@montezuma.mastecende.com>
 <20030610153815.57f7a563.skraw@ithnet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jun 2003, Stephan von Krawczynski wrote:

> On Tue, 10 Jun 2003 08:51:35 -0400 (EDT)
> Zwane Mwaikambo <zwane@linuxpower.ca> wrote:
> 
> > > Can you clarify? Do you mean options "nosmp noapic" or just "noapic" on SMP
> > > kernel?
> > 
> > Kernel built with CONFIG_SMP and booted with 'noapic' kernel parameter
> 
> Ok. To speed up the tests I  call it "ok" if there are no verify errors within
> 70 GB and "fail" if there are one or more.
> I have tried rc7+aic20030603 SMP with noapic and it is ok.

Can you also test it with an SMP kernel and only maxcpus=1 ?

> Reading around the whole interrupt stuff I came across a very simple idea which
> I am going to test right now. See you in some hours ;-)

Cool

	Zwane
-- 
function.linuxpower.ca
