Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030181AbVHZSpf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030181AbVHZSpf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 14:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965173AbVHZSpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 14:45:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:11194 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965172AbVHZSpe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 14:45:34 -0400
Date: Fri, 26 Aug 2005 14:45:20 -0400
From: Dave Jones <davej@redhat.com>
To: Robert Love <rml@novell.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Brian Gerst <bgerst@didntduck.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] IBM HDAPS accelerometer driver.
Message-ID: <20050826184520.GE20541@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Robert Love <rml@novell.com>,
	Arjan van de Ven <arjan@infradead.org>,
	Brian Gerst <bgerst@didntduck.org>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1125069494.18155.27.camel@betsy> <430F5257.4010700@didntduck.org> <1125077594.18155.52.camel@betsy> <1125079311.4294.10.camel@laptopd505.fenrus.org> <1125079430.18155.64.camel@betsy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1125079430.18155.64.camel@betsy>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2005 at 02:03:50PM -0400, Robert Love wrote:
 > On Fri, 2005-08-26 at 20:01 +0200, Arjan van de Ven wrote:
 > 
 > > > Not that we've been able to tell.  It is a legacy platform device.
 > > > 
 > > > So, unfortunately, no probe() routine.
 > > 
 > > dmi surely....
 > 
 > Patches accepted.

A little difficult for people to submit dmi patches, unless they
have hardware this driver runs on.   Surely as you've tested this,
you're in the best position to write such patches :-)

		Dave

