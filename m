Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272373AbTHIOcV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 10:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272366AbTHIOcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 10:32:21 -0400
Received: from filesrv1.system-techniques.com ([199.33.245.55]:52705 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id S272378AbTHIOcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 10:32:21 -0400
Date: Sat, 9 Aug 2003 10:32:02 -0400 (EDT)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: gaxt <gaxt@rogers.com>
cc: preining@logic.at, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test3 cannot mount root fs
In-Reply-To: <3F34D0EA.8040006@rogers.com>
Message-ID: <Pine.LNX.4.56.0308091030590.16795@filesrv1.baby-dragons.com>
References: <3F34D0EA.8040006@rogers.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	He3llo Gaxt ,  Is this change to the lilo.conf funtionality
	documented someplace ?  It is not in the halloween-2.5 document .
		Tia ,  JimL

On Sat, 9 Aug 2003, gaxt wrote:
>  > I am trying 2.6.0-test3 but cannot get the kernel to mount /dev/hdb1
>  > which is the root fs.
> Try changing in your bootloader root=/dev/hdb1 to root=341
-- 
       +------------------------------------------------------------------+
       | James   W.   Laferriere | System    Techniques | Give me VMS     |
       | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
       | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
       +------------------------------------------------------------------+
