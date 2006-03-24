Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751570AbWCXHac@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751570AbWCXHac (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 02:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751569AbWCXHab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 02:30:31 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:34182
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751568AbWCXHab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 02:30:31 -0500
Date: Thu, 23 Mar 2006 23:29:03 -0800 (PST)
Message-Id: <20060323.232903.34304885.davem@davemloft.net>
To: akpm@osdl.org
Cc: arjan@infradead.org, yang.y.yi@gmail.com, linux-kernel@vger.kernel.org,
       johnpol@2ka.mipt.ru, matthltc@us.ibm.com
Subject: Re: [2.6.16 PATCH] Connector: Filesystem Events Connector v3
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060323232345.1ca16f3f.akpm@osdl.org>
References: <1143183541.2882.7.camel@laptopd505.fenrus.org>
	<20060323.230649.11516073.davem@davemloft.net>
	<20060323232345.1ca16f3f.akpm@osdl.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
Date: Thu, 23 Mar 2006 23:23:45 -0800

> "David S. Miller" <davem@davemloft.net> wrote:
> >
> > From: Arjan van de Ven <arjan@infradead.org>
> >  Date: Fri, 24 Mar 2006 07:59:01 +0100
> > 
> >  > then make the syslog part optional.. if it's not already!
> > 
> >  Regardless I still think the filesystem events connector is a useful
> >  facility.
> 
> Why's that?

You chopped off the next paragraph where I say why :)

> (I'd viewed it as a fun thing, but I haven't really seen much pull for it,
> and the scalability issues in there aren't trivial).

That's a good point, however.
