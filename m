Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262814AbVCDAfN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262814AbVCDAfN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 19:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262829AbVCDAcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 19:32:04 -0500
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:33470 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262724AbVCDA2l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 19:28:41 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Alexander Nyberg <alexn@dsv.su.se>
Subject: Re: Keyboard doesn't work with CONFIG_PNP in 2.6.11-rc5-mm1
Date: Thu, 3 Mar 2005 19:28:30 -0500
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <1109887099.2286.15.camel@boxen>
In-Reply-To: <1109887099.2286.15.camel@boxen>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503031928.33106.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 March 2005 16:58, Alexander Nyberg wrote:
> Hi!
> 
> I had accidently chosen CONFIG_PNP and noticed that my keyboard didn't
> work with bk-dtor-input.patch in the tree (backing out makes keyboard
> work).
> 

Hi,

It looks like some old stuff in my tree overwrites good stuff from
Vojtech's tree.. Thanks for letting me know.

Nonetheless, could you please send me your DSDT - I wonder why
your keyboard controller is not detected.

Thanks!

-- 
Dmitry
