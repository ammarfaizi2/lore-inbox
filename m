Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030223AbVHZT1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030223AbVHZT1F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 15:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030226AbVHZT1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 15:27:05 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:39084 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030223AbVHZT1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 15:27:03 -0400
Subject: Re: [patch] IBM HDAPS accelerometer driver.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Robert Love <rml@novell.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Brian Gerst <bgerst@didntduck.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1125079430.18155.64.camel@betsy>
References: <1125069494.18155.27.camel@betsy>
	 <430F5257.4010700@didntduck.org>  <1125077594.18155.52.camel@betsy>
	 <1125079311.4294.10.camel@laptopd505.fenrus.org>
	 <1125079430.18155.64.camel@betsy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 26 Aug 2005 20:55:34 +0100
Message-Id: <1125086134.14080.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-08-26 at 14:03 -0400, Robert Love wrote:
> On Fri, 2005-08-26 at 20:01 +0200, Arjan van de Ven wrote:
> 
> > > Not that we've been able to tell.  It is a legacy platform device.
> > > 
> > > So, unfortunately, no probe() routine.
> > 
> > dmi surely....
> 
> Patches accepted.

I think that should be fixed before its merged.

Alan

