Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265016AbUD2WlH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265016AbUD2WlH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 18:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265014AbUD2WlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 18:41:06 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5264 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265016AbUD2WlD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 18:41:03 -0400
Date: Thu, 29 Apr 2004 23:40:57 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Marc Boucher <marc@linuxant.com>
Cc: koke@sindominio.net, Paul Wagland <paul@wagland.net>,
       linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
       Rik van Riel <riel@redhat.com>,
       David Gibson <david@gibson.dropbear.id.au>,
       Timothy Miller <miller@techsource.com>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
Message-ID: <20040429224057.GQ17014@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.44.0404291114150.9152-100000@chimarrao.boston.redhat.com> <4FE43C97-9A20-11D8-B804-000A95CD704C@wagland.net> <4091757B.3090209@techsource.com> <200404292347.17431.koke_lkml@amedias.org> <0CAE0144-9A2C-11D8-B83D-000A95BCAC26@linuxant.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0CAE0144-9A2C-11D8-B83D-000A95BCAC26@linuxant.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2004 at 06:24:58PM -0400, Marc Boucher wrote:
> 
> The inherent instability of binary modules is a religious myth. Any 
> module can be stable or unstable, depending on how it's written, tested 
> and the environment (hardware/evolving APIs it depends on). For 
> example, Apple's current Mac OS X is extremely stable imho, despite the 
> fact that their hardware drivers are generally binary-only.
> 
> The same goes for trustworthiness. It's a matter of point of view / 
> preference whether you trust open-source projects and their security 
> (which can be far from perfect, as evidenced by the recent break-ins in 
> various servers hosting source repositories) more than stuff produced 
> by a corporation. Every model has disadvantages and advantages. 

You are missing the point.  Badly.  All software sucks, be it open-source
of proprietary.  The only question is what can be done with particular
instance of suckage, and that's where having the source matters.
