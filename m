Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266008AbUEUS7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266008AbUEUS7V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 14:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266009AbUEUS7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 14:59:21 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:32672 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S266008AbUEUS7T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 14:59:19 -0400
Date: Fri, 21 May 2004 20:55:03 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Laurent Goujon <laurent.goujon@online.fr>
Cc: Rudo Thomas <rudo@matfyz.cz>, linux-kernel@vger.kernel.org
Subject: Re: Sluggish performances with FreeBSD
Message-ID: <20040521205503.A18763@electric-eye.fr.zoreil.com>
References: <1085080302.7764.20.camel@caribou.no-ip.org> <20040520193406.GA16184@ss1000.ms.mff.cuni.cz> <1085083195.4240.4.camel@caribou.no-ip.org> <20040520232957.A2172@electric-eye.fr.zoreil.com> <1085091424.4238.13.camel@caribou.no-ip.org> <20040521003616.D2172@electric-eye.fr.zoreil.com> <1085093395.4238.22.camel@caribou.no-ip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1085093395.4238.22.camel@caribou.no-ip.org>; from laurent.goujon@online.fr on Fri, May 21, 2004 at 12:49:55AM +0200
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Laurent Goujon <laurent.goujon@online.fr> :
[...]
> > This one is probably for Daniele Venzano (webvenza@libero.it).
> > You should check the l-k archive from 05/18/2004 and 05/19/2004
> > (search for the subject: Re: [PATCH] Sis900 bug fixes 3/4).
> I've checked this one before posting but in my case, I've only one PHY
> transceiver according to dmesg, so this patch has probably no effect...

Right. Care to send 'mii-tool -vv' before we resort to crystal ball ?

--
Ueimor
