Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264647AbTFYQci (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 12:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264650AbTFYQci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 12:32:38 -0400
Received: from [62.29.72.95] ([62.29.72.95]:21376 "EHLO submoron.org")
	by vger.kernel.org with ESMTP id S264647AbTFYQch (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 12:32:37 -0400
From: "ismail (cartman) donmez" <kde@myrealbox.com>
Organization: Bogazici University
To: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: Weird modem behaviour in 2.5.73-mm1
Date: Wed, 25 Jun 2003 19:47:48 +0300
User-Agent: KMail/1.5.9
References: <200306242102.49356.kde@myrealbox.com> <200306250418.h5P4IWdA001565@turing-police.cc.vt.edu> <20030625091013.573f2e7b.shemminger@osdl.org>
In-Reply-To: <20030625091013.573f2e7b.shemminger@osdl.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
   =?ISO-8859-1?Q?=20charset=3D=22=FDso-885?= =?ISO-8859-1?Q?9-1=22?=
Content-Transfer-Encoding: 7bit
Message-Id: <200306251947.48819.kde@myrealbox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 25 June 2003 19:10, Stephen Hemminger wrote:
> On Wed, 25 Jun 2003 00:18:31 -0400
>
> Valdis.Kletnieks@vt.edu wrote:
> > On Tue, 24 Jun 2003 23:27:57 EDT, Valdis.Kletnieks@vt.edu said:
> >
> > Reverting this one cset makes the modem work for me under 2.5.73-mm1.
> > With it in place, pppd hung up before even finishing the option
> > negotiations.  With it reverted, it's staying up.  There's apparently
> > something subtly wrong with the part that hits ppp_generic.c, although
> > I admit not understanding enough to see exactly what.
>
> How far along did pppd get before it hung up?

For me its random between 1-5 minutes.

Regards,
/ismail
