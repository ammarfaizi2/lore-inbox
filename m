Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261569AbTITHHr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Sep 2003 03:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261580AbTITHHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Sep 2003 03:07:47 -0400
Received: from mail-06.iinet.net.au ([203.59.3.38]:13188 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261569AbTITHHq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Sep 2003 03:07:46 -0400
Subject: Re: Problems with airo/airo_cs since test4-bk2
From: Sven Dowideit <svenud@ozemail.com.au>
To: "Jeremy T. Bouse" <Jeremy.Bouse@UnderGrid.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030919030037.GA5581@UnderGrid.net>
References: <20030919030037.GA5581@UnderGrid.net>
Content-Type: text/plain
Message-Id: <1064077301.14771.1.camel@sven>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sun, 21 Sep 2003 03:01:41 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-09-19 at 13:00, Jeremy T. Bouse wrote:
> 	Since test4-bk2 I've still had increasing problems with the
> airo/airo_cs driver... test4-bk2 operates but generates an awful lot of
> frame errors... I've tried test5-bk1 , bk3 and bk5 and they fail to even
> be able to associate with the AP at all and totally unusable... As soon
> as the driver and/or card are removed it causes an oops unlike earlier
> test versions which would just lock the whole machine up...
i have a cisco 340 in my thinkpad t21 that has been fine so far
(especially after Rusty fixed the detection problems)
> 
> 	Has anyone else been noticing these problems with a Cisco Aironet 350?
> I've got it in a Sony Vaio PCG-C1MWP and use it on two networks which
> use either a LinkSys WAP11 or an Orinoco AP-1000 with the same
> results...
> 
> 	Regards,
> 	Jeremy

