Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261792AbTIEBKr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 21:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261801AbTIEBKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 21:10:47 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:16904 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S261792AbTIEBK3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 21:10:29 -0400
From: Michael Frank <mhf@linuxmail.org>
To: Pavel Machek <pavel@suse.cz>, Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: swsusp: revert to 2.6.0-test3 state
Date: Fri, 5 Sep 2003 09:09:20 +0800
User-Agent: KMail/1.5.2
Cc: Patrick Mochel <mochel@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.33.0309040820520.940-100000@localhost.localdomain> <1062703732.12025.7.camel@laptop-linux> <20030904193105.GF27650@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20030904193105.GF27650@atrey.karlin.mff.cuni.cz>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200309050852.26430.mhf@linuxmail.org>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 05 September 2003 03:31, Pavel Machek wrote:
> It puts you in a better position, AFAICS. When code is rewritten
> anyway, "don't fix it if it aint broken" is not so important any
> more -- good for you.
>
> I still hope to avoid two software suspends in 2.6.X.
>
Bah, there may be three implementations now.

On Tuesday 02 September 2003 06:55, Patrick Mochel wrote:
>
> In all actuality, I don't need swsusp. I have a better suspend-to-disk
> implementation that is faster, smaller, and cleaner. I've hesitated
> merging it because I thought swsusp improvements would be more welcome.
> Obviously they're not; or you haven't actually taken the time to read the
> code.
>

This looks like a democratic (darwinistic) approach which will help to get
the best solution for 2.6.

Regards
Michael

