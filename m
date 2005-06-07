Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261911AbVFGTeB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261911AbVFGTeB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 15:34:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261878AbVFGTeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 15:34:00 -0400
Received: from mailfe02.swip.net ([212.247.154.33]:14770 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261872AbVFGTdh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 15:33:37 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: oops 2.6.11 and 2.6.12-rc6
From: Alexander Nyberg <alexn@telia.com>
To: Lawrence Walton <lawrence@the-penguin.otak.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050607182329.GA3950@the-penguin.otak.com>
References: <20050607182329.GA3950@the-penguin.otak.com>
Content-Type: text/plain
Date: Tue, 07 Jun 2005 21:33:29 +0200
Message-Id: <1118172809.956.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tis 2005-06-07 klockan 11:23 -0700 skrev Lawrence Walton:
> Hello!
> 
> I have a production server that has not booted any kernel I've tried sense
> 2.6.10.
> I captured this oops by *hand* this morning when trying to boot 2.6.12-rc6.
> 
> I've included the decoded oops, lspci -vvv, .config and ver_linux information.
> 
> Unlike most cases this is a prodution machine and I have limited time to test patches. :(
> 

Unfortunately the oops text you sent cannot be used for debugging.
Please send the oops that 2.6.12-rc6 produces to the list (ksymoops is
not necessary on 2.6.x kernels and should not be used!). 
Depending on how early the oops happens you can definately use
Documentation/serial-console.txt and maybe the somewhat simpler
Documentation/networking/netconsole.txt

Please send the non-ksymoopsed oops you wrote off the screen when
booting 2.6.12-rc6

Thanks

