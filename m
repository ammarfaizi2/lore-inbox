Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262055AbVCAUh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262055AbVCAUh2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 15:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262054AbVCAUh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 15:37:28 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:49374 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262055AbVCAUgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 15:36:55 -0500
Subject: Re: Network speed Linux-2.6.10
From: Lee Revell <rlrevell@joe-job.com>
To: Miquel van Smoorenburg <miquels@cistron.nl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <d02jcf$ci6$1@news.cistron.nl>
References: <Pine.LNX.4.61.0503011426180.578@chaos.analogic.com>
	 <4224CE98.2060204@candelatech.com> <1109708691.14272.8.camel@mindpipe>
	 <d02jcf$ci6$1@news.cistron.nl>
Content-Type: text/plain
Date: Tue, 01 Mar 2005 15:36:49 -0500
Message-Id: <1109709409.17405.4.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-01 at 20:30 +0000, Miquel van Smoorenburg wrote:
> In article <1109708691.14272.8.camel@mindpipe>,
> Lee Revell  <rlrevell@joe-job.com> wrote:
> >On Tue, 2005-03-01 at 12:20 -0800, Ben Greear wrote:
> >> What happens if you just don't muck with the NIC and let it auto-negotiate
> >> on it's own?
> >
> >This can be asking for trouble too (auto negotiation is often buggy).
> >What if you hard set them both to 100/full?
> 
> If you do that you also need to force the switchports to full duplex.
> Lots of switches default to half-duplex without auto-negotiation.
> 

Yup, that was exactly what we ended up doing.

Lee

