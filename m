Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268307AbUHFVHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268307AbUHFVHP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 17:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268309AbUHFVHO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 17:07:14 -0400
Received: from cantor.suse.de ([195.135.220.2]:2275 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268307AbUHFVHI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 17:07:08 -0400
Date: Fri, 6 Aug 2004 23:07:04 +0200
From: Karsten Keil <kkeil@suse.de>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Pedro Marques <pedro_m@yahoo.com>, linux-kernel@vger.kernel.org,
       kai.germaschewski@gmx.de, isdn4linux@listserv.isdn4linux.de
Subject: Re: [patch] update email address of Pedro Roque Marques
Message-ID: <20040806210704.GB19193@pingi3.kke.suse.de>
Mail-Followup-To: Adrian Bunk <bunk@fs.tum.de>,
	Pedro Marques <pedro_m@yahoo.com>, linux-kernel@vger.kernel.org,
	kai.germaschewski@gmx.de, isdn4linux@listserv.isdn4linux.de
References: <20040715210828.GK25633@fs.tum.de> <20040715215542.94441.qmail@web41114.mail.yahoo.com> <20040806200653.GD2746@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040806200653.GD2746@fs.tum.de>
Organization: SuSE Linux AG
X-Operating-System: Linux 2.6.5-7.95-default i686
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2004 at 10:06:54PM +0200, Adrian Bunk wrote:
> On Thu, Jul 15, 2004 at 02:55:42PM -0700, Pedro Marques wrote:
> > 
> > btw: i wonder if the PCBIT isdn driver is still used
> > by anyone. I may be a good idea to just remove it from
> > the kernel dist. It was never a very popular adapter.
> >...
> 
> There's many strange hardware supported in Linux that surprisingly has 
> users.

Yes, unfortunatly we always have some users :-)
I got patches form users and 2 or 3 questions last year.

> 
> But regarding the PCBIT the ISDN maintainers (Cc'ed) should be better to 
> gave an answer.
> 

My plan was to not port this driver (and some others) to the next generation
linux ISDN driver (or only if here a lot of complains) so it will go away in
2005 I hope.

-- 
Karsten Keil
SuSE Labs
ISDN development
