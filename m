Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261385AbVBNK2V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261385AbVBNK2V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 05:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261384AbVBNK2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 05:28:21 -0500
Received: from pop.gmx.de ([213.165.64.20]:61586 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261386AbVBNK2J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 05:28:09 -0500
X-Authenticated: #8956447
Subject: Re: [Problem] slow write to dvd-ram since 2.6.7-bk8
From: Droebbel <droebbel.melta@gmx.de>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20050214085320.GA4910@dose.home.local>
References: <1108301794.9280.18.camel@localhost.localdomain>
	 <20050213142635.GA2035@animx.eu.org>
	 <20050214085320.GA4910@dose.home.local>
Content-Type: text/plain
Date: Mon, 14 Feb 2005 11:28:06 +0100
Message-Id: <1108376886.9495.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.1.5 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mo, 2005-02-14 at 09:53 +0100, Tino Keitel wrote:
>I also have low write performance (around 300 kb/s) with several 2.6
>kernels (2.6.7 to 2.6.9-mm1) and I can hear the head jump around when I
>use ext2 or UDF. It will be fast when written directly to the device
>without a file system using dd.  The drive is a LG GSA-4040B. I tried
>several media types from Panasonic and EMTEC.
>
>I'll try to test if the problem disappears with 2.6.6.

I had also tested writing with dd (forgot to mention), it seemed faster
sometimes, but not as fast as it could be. pre-2.6.7-bk8 was still
faster, though only about 25%.

Which 2.6.7 did you use? 

Regards
David

