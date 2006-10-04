Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751086AbWJDUUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbWJDUUJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 16:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbWJDUUJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 16:20:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16362 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751086AbWJDUUG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 16:20:06 -0400
Date: Wed, 4 Oct 2006 13:12:17 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jean Tourrilhes <jt@hpl.hp.com>
cc: "John W. Linville" <linville@tuxdriver.com>, Jeff Garzik <jeff@garzik.org>,
       Lee Revell <rlrevell@joe-job.com>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Norbert Preining <preining@logic.at>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, johannes@sipsolutions.net
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
In-Reply-To: <20061004195229.GA4459@bougret.hpl.hp.com>
Message-ID: <Pine.LNX.4.64.0610041311420.3952@g5.osdl.org>
References: <20061003180543.GD23912@tuxdriver.com> <4522A9BE.9000805@garzik.org>
 <20061003183849.GA17635@bougret.hpl.hp.com> <4522B311.7070905@garzik.org>
 <20061003214038.GE23912@tuxdriver.com> <Pine.LNX.4.64.0610031454420.3952@g5.osdl.org>
 <20061004181032.GA4272@bougret.hpl.hp.com> <Pine.LNX.4.64.0610041133040.3952@g5.osdl.org>
 <20061004185903.GA4386@bougret.hpl.hp.com> <Pine.LNX.4.64.0610041216510.3952@g5.osdl.org>
 <20061004195229.GA4459@bougret.hpl.hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 4 Oct 2006, Jean Tourrilhes wrote:
> 
> 	Yes, this is precisely what we have been doing, the two APIs
> have been working at the same time for more than 6 months.

In the kernel for any particular driver?

Or just in user-land?

There's a big difference.

			Linus
