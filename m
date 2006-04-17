Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750918AbWDQU1A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918AbWDQU1A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 16:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750930AbWDQU1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 16:27:00 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:57274
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750918AbWDQU07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 16:26:59 -0400
Date: Mon, 17 Apr 2006 13:27:16 -0700 (PDT)
Message-Id: <20060417.132716.31966630.davem@davemloft.net>
To: arjan@infradead.org
Cc: chrisw@sous-sol.org, jmorris@namei.org, hch@infradead.org, akpm@osdl.org,
       sds@tycho.nsa.gov, edwin@gurde.com,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: Time to remove LSM
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <1145305493.2847.86.camel@laptopd505.fenrus.org>
References: <Pine.LNX.4.64.0604171454070.17563@d.namei>
	<20060417202037.GB3615@sorel.sous-sol.org>
	<1145305493.2847.86.camel@laptopd505.fenrus.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arjan van de Ven <arjan@infradead.org>
Date: Mon, 17 Apr 2006 22:24:53 +0200

> On Mon, 2006-04-17 at 13:20 -0700, Chris Wright wrote:
> > * James Morris (jmorris@namei.org) wrote:
> > > How about enough time to get us to 2.6.18, say, two months?
> > 
> > Based on the discussions we had last year, I think the fair date would
> > be August not June.
> 
> why?
> this is already a year notice...
> lets get it over with.. notice goes in now
> removal to -mm, goes into 2.6.18

I totally agree, let's get rid of it in 2.6.18, it serves no
real purpose.
