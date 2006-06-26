Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932140AbWFZC2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbWFZC2v (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 22:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbWFZC2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 22:28:51 -0400
Received: from mail.gmx.net ([213.165.64.21]:17315 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751409AbWFZC2v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 22:28:51 -0400
X-Authenticated: #14349625
Subject: Re: Measuring tools - top and interrupts
From: Mike Galbraith <efault@gmx.de>
To: danial_thom@yahoo.com
Cc: =?ISO-8859-1?Q?=22Bj=F6rn=22?= Steinbrink <B.Steinbrink@gmx.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060625204553.52734.qmail@web33307.mail.mud.yahoo.com>
References: <20060625204553.52734.qmail@web33307.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Mon, 26 Jun 2006 04:33:02 +0200
Message-Id: <1151289182.7470.31.camel@Homer.TheSimpsons.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-06-25 at 13:45 -0700, Danial Thom wrote:

> I think the one thing we can surmise from this
> thread is that you can't rely on kernel usage
> statistics to be accurate, as its likely that
> there are many, many cases that don't work
> properly. It was always wrong in 2.4 as well.

Once identified, problems tend to get fixed.  This one will probably be
history soon.  You know the old saying though... "There are lies, there
are _damn_ lies, and then there are _statistics_".

