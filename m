Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261823AbTFJKt7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 06:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261843AbTFJKt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 06:49:59 -0400
Received: from zmamail04.zma.compaq.com ([161.114.64.104]:54795 "EHLO
	zmamail04.zma.compaq.com") by vger.kernel.org with ESMTP
	id S261823AbTFJKt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 06:49:58 -0400
Date: Tue, 10 Jun 2003 13:05:01 +0200
From: Torben Mathiasen <torben.mathiasen@hp.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       "Grover, Andrew" <andrew.grover@intel.com>,
       Grzegorz Jaskiewicz <gj@pointblue.com.pl>,
       lkml <linux-kernel@vger.kernel.org>,
       "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Brown, Len" <len.brown@intel.com>,
       "Therien, Guy" <guy.therien@intel.com>
Subject: Re: 2.4.22 timeline was RE: 2.4.21-rc7 ACPI broken
Message-ID: <20030610110501.GB1457@tmathiasen>
References: <F760B14C9561B941B89469F59BA3A84725A2DF@orsmsx401.jf.intel.com> <Pine.LNX.4.55L.0306091901260.27584@freak.distro.conectiva> <1055205899.31139.15.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1055205899.31139.15.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
X-OS: Linux 2.4.21-rc7 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 10 2003, Alan Cox wrote:
> On Llu, 2003-06-09 at 23:03, Marcelo Tosatti wrote:
> > Yes, I want to, and will merge it. In 2.4.23-pre.
> > 
> > > I am confident it will merge cleanly.
> > > I am confident it will cause no problems when CONFIG_ACPI=off.
> > > I am confident the total number of working machines will go up.
> > > I am willing to bet $500 of MY OWN MONEY on this.
> > >
> > > Talk to me, man. What would make you happy? A lot is riding on this.
> > 
> > Yes, we're fine. 2.4.23-pre.
> > 
> > 2.4.22 will be a fast enough release to not piss you off on this, trust
> > me.
> 
> Its been in 2.4.21-ac for a while. I have exactly zero reports of it
> causing problems in the acpi=n case, and a whole raft of "the first
> Linux that runs on my toshiba/compaq/hp laptop"
> 
> Works well enough for me to have faith in it now. 

We need it as well to have proper ACPI support on the Hp/cpq laptops. Without
it one may get serious overheating problems. 

We've been waiting for it for a long time now.

Thanks.
