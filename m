Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272324AbTHNM3o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 08:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272338AbTHNM3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 08:29:44 -0400
Received: from baloney.puettmann.net ([194.97.54.34]:37570 "EHLO
	baloney.puettmann.net") by vger.kernel.org with ESMTP
	id S272324AbTHNM3m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 08:29:42 -0400
Date: Thu, 14 Aug 2003 14:28:45 +0200
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mikael Pettersson <mikpe@csd.uu.se>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.22 APM problems with IBM Thinkpad's
Message-ID: <20030814122845.GA2264@puettmann.net>
References: <20030813123119.GA25111@puettmann.net> <16186.14686.455795.927909@gargle.gargle.HOWL> <1060783884.8008.64.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060783884.8008.64.camel@dhcp23.swansea.linux.org.uk>
User-Agent: Mutt/1.5.4i
From: Ruben Puettmann <ruben@puettmann.net>
X-Scanner: exiscan *19nHDh-0000am-00*hDstr3wgqXs* (Puettmann.NeT, Germany)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 13, 2003 at 03:11:27PM +0100, Alan Cox wrote:
> On Mer, 2003-08-13 at 14:13, Mikael Pettersson wrote:
> > With APIC support enabled (SMP or UP_APIC), APM must be constrained:
> > DISPLAY_BLANK off
> > CPU_IDLE off
> > built-in driver, not module
> 
> This isnt sufficient because some of the SMM traps off the FN-key 
> sequences also crash thinkpads if APIC is enabled. Basically *dont use
> local apic* except on SMP.

sorry but why breaks this all under linux? O.K im not a friend if
windows but on the preinstalled windowsXP it runs all fine.

Is this a problem of manpower or missing spec's? 

        Ruben

-- 
Ruben Puettmann
ruben@puettmann.net
http://www.puettmann.net
