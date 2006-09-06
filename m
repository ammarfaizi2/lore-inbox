Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751191AbWIFOef@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbWIFOef (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 10:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbWIFOef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 10:34:35 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:52659 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1751191AbWIFOee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 10:34:34 -0400
Subject: Re: lockdep oddity
From: Daniel Walker <dwalker@mvista.com>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Ingo Molnar <mingo@elte.hu>, Hua Zhong <hzhong@gmail.com>,
       "'Andrew Morton'" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "'Arjan van de Ven'" <arjan@infradead.org>
In-Reply-To: <20060906142928.GF6898@osiris.boeblingen.de.ibm.com>
References: <20060906080129.GD6898@osiris.boeblingen.de.ibm.com>
	 <004901c6d18d$acc45620$0200a8c0@nuitysystems.com>
	 <20060906084021.GA30856@elte.hu>
	 <1157552359.3541.16.camel@c-67-188-28-158.hsd1.ca.comcast.net>
	 <20060906142928.GF6898@osiris.boeblingen.de.ibm.com>
Content-Type: text/plain
Date: Wed, 06 Sep 2006 07:34:32 -0700
Message-Id: <1157553272.3541.21.camel@c-67-188-28-158.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-06 at 16:29 +0200, Heiko Carstens wrote:
> On Wed, Sep 06, 2006 at 07:19:19AM -0700, Daniel Walker wrote:
> > > the current code needs more work before it can go upstream i think.
> > 
> > It was never really planned to go upstream. It's ultimately a debugging
> > feature that's really only needed in -mm .. 
> 
> And I thought the -mm tree was supposed to contain only code that will
> go upstream sooner or later (unless it gets dropped for some reason).

Nope .. There are other -mm only patches. 

Daniel

