Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964850AbWHLOdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964850AbWHLOdG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 10:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964848AbWHLOdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 10:33:05 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:22158 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S964835AbWHLOdB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 10:33:01 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Jeff Garzik <jeff@garzik.org>
Subject: Re: 2.6.18-rc3-mm2 (+ hotfixes): GPF related to skge on suspend
Date: Sat, 12 Aug 2006 16:32:19 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Stephen Hemminger <shemminger@osdl.org>, netdev@vger.kernel.org
References: <200608121207.42268.rjw@sisk.pl> <20060812052853.f9e5d648.akpm@osdl.org> <44DDDA2F.4080404@garzik.org>
In-Reply-To: <44DDDA2F.4080404@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608121632.19070.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 12 August 2006 15:39, Jeff Garzik wrote:
> Andrew Morton wrote:
> > It would be good if you could poke around in gdb, work out exactly which
> > statement it's oopsing at, please.
> 
> I'm also interested to know if the problem goes away when you disable 
> preempt...

That will take some time to test. :-)

Rafael
