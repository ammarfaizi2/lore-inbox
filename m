Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135323AbRECWk7>; Thu, 3 May 2001 18:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135284AbRECWkj>; Thu, 3 May 2001 18:40:39 -0400
Received: from p3EE3CDDC.dip.t-dialin.net ([62.227.205.220]:42507 "HELO
	emma1.emma.line.org") by vger.kernel.org with SMTP
	id <S135336AbRECWki>; Thu, 3 May 2001 18:40:38 -0400
Date: Fri, 4 May 2001 00:40:34 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.3 2.4.4pre8: aic7xxx showstopper bug fails to detect sda
Message-ID: <20010504004034.A29494@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010428202225.D11994@emma1.emma.line.org> <PGEDKPCOHCLFJBPJPLNMCEDICMAA.denali@sunflower.com> <20010429122546.A1419@werewolf.able.es> <20010430013956.A1578@emma1.emma.line.org> <200104301340.f3UDeN115068@pcx4168.holstein.com> <20010430163045.A13230@emma1.emma.line.org> <3AED7885.A2E4F91B@holstein.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AED7885.A2E4F91B@holstein.com>; from troy@holstein.com on Mon, Apr 30, 2001 at 10:36:53 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Apr 2001, Todd M. Roy wrote:

>   I tried 2.4.4 with the old aic7xxxx driver and it worked fine.

That may be true, and it may help the deployment of 2.4.4 on that
particular machine, but the kernel needs the bugfix anyways, and
reporting the bug is the least I can do. If I'm after "old" drivers, I
can stick with 2.2.19 :-)
