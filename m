Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262518AbTIPT7A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 15:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262519AbTIPT7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 15:59:00 -0400
Received: from dspnet.fr.eu.org ([62.73.5.179]:47366 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S262518AbTIPT67 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 15:58:59 -0400
Date: Tue, 16 Sep 2003 21:58:58 +0200
From: Olivier Galibert <galibert@limsi.fr>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Stephan von Krawczynski <skraw@ithnet.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       neilb@cse.unsw.edu.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: experiences beyond 4 GB RAM with 2.4.22
Message-ID: <20030916195858.GC68728@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@limsi.fr>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Stephan von Krawczynski <skraw@ithnet.com>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
	neilb@cse.unsw.edu.au,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030916102113.0f00d7e9.skraw@ithnet.com> <Pine.LNX.4.44.0309161009460.1636-100000@logos.cnet> <20030916153658.3081af6c.skraw@ithnet.com> <1063722973.10037.65.camel@dhcp23.swansea.linux.org.uk> <20030916172057.148a5741.skraw@ithnet.com> <1063726141.10036.130.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1063726141.10036.130.camel@dhcp23.swansea.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 16, 2003 at 04:29:02PM +0100, Alan Cox wrote:
> The kernel has no idea what you will do with given ram. It does try to
> make some guesses but you are basically trying to paper over hardware
> limits.

Is there a way to specifically turn that ram into a tmpfs though?

  OG.
