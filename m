Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261673AbVBHWkt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbVBHWkt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 17:40:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261674AbVBHWjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 17:39:00 -0500
Received: from palrel13.hp.com ([156.153.255.238]:34463 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S261673AbVBHWhr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 17:37:47 -0500
Date: Tue, 8 Feb 2005 14:37:15 -0800
To: "David S. Miller" <davem@davemloft.net>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4] SIOCSIFNAME wildcard support (resend)
Message-ID: <20050208223715.GA5739@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20050208181436.GA29717@bougret.hpl.hp.com> <20050208180445.GB10695@logos.cnet> <20050208142422.019e2b01.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050208142422.019e2b01.davem@davemloft.net>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2005 at 02:24:22PM -0800, David S. Miller wrote:
> On Tue, 8 Feb 2005 16:04:45 -0200
> Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
> 
> > On Tue, Feb 08, 2005 at 10:14:36AM -0800, Jean Tourrilhes wrote:
> > > 	Hi Marcelo,
> > > 
> > > 	I did not receive any feedback on this e-mail, so I assume it
> > > was lost on the way. Would you mind pushing that in 2.4.x ?
> > > 	Thanks...
> > 
> > As an ignorant person I have no problems with it.
> > 
> > David, what is your opinion?
> 
> If networking patches are sent purely to linux-kernel, they will often
> be missed.  Please use netdev@oss.sgi.com, Jean of all people should be
> more than aware of netdev@oss.sgi.com as the place to post and discuss
> networking patches, not linux-kernel and not privately to Marcelo or
> myself.
> 
> I only happened to spot this post by accident this time, I'm being
> asked a question and I'm not even CC:'d on the email. :-)

	It was sent to netdev :
http://marc.theaimsgroup.com/?l=linux-netdev&m=110747857226852&w=2

	Jean
