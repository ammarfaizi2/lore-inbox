Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751864AbWIGT0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751864AbWIGT0Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 15:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751867AbWIGT0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 15:26:25 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:54025 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1751864AbWIGT0X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 15:26:23 -0400
Date: Thu, 7 Sep 2006 19:25:28 +0000
From: Pavel Machek <pavel@suse.cz>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Jeff Garzik <jgarzik@pobox.com>, Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, netdev@vger.kernel.org,
       Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [patch 37/37] sky2: version 1.6.1
Message-ID: <20060907192528.GG8793@ucw.cz>
References: <20060906224631.999046890@quad.kroah.org> <20060906225812.GL15922@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060906225812.GL15922@kroah.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 06-09-06 15:58:12, Greg KH wrote:
> -stable review patch.  If anyone has any objections, please let us know.
> 
> ------------------
> From: Stephen Hemminger <shemminger@osdl.org>
> 
> Since this code incorporates some of the fixes from 2.6.18, change
> the version number.
> 
> Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

Not sure, one of 'stable' criteria is 'fixes bad bug'. What bug does
this fix?

							Pavel
-- 
Thanks for all the (sleeping) penguins.
