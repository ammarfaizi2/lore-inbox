Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261598AbVBHWcb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261598AbVBHWcb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 17:32:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261596AbVBHWbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 17:31:08 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:15569
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261593AbVBHWa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 17:30:56 -0500
Date: Tue, 8 Feb 2005 14:24:22 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: jt@hpl.hp.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4] SIOCSIFNAME wildcard support (resend)
Message-Id: <20050208142422.019e2b01.davem@davemloft.net>
In-Reply-To: <20050208180445.GB10695@logos.cnet>
References: <20050208181436.GA29717@bougret.hpl.hp.com>
	<20050208180445.GB10695@logos.cnet>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Feb 2005 16:04:45 -0200
Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:

> On Tue, Feb 08, 2005 at 10:14:36AM -0800, Jean Tourrilhes wrote:
> > 	Hi Marcelo,
> > 
> > 	I did not receive any feedback on this e-mail, so I assume it
> > was lost on the way. Would you mind pushing that in 2.4.x ?
> > 	Thanks...
> 
> As an ignorant person I have no problems with it.
> 
> David, what is your opinion?

If networking patches are sent purely to linux-kernel, they will often
be missed.  Please use netdev@oss.sgi.com, Jean of all people should be
more than aware of netdev@oss.sgi.com as the place to post and discuss
networking patches, not linux-kernel and not privately to Marcelo or
myself.

I only happened to spot this post by accident this time, I'm being
asked a question and I'm not even CC:'d on the email. :-)
