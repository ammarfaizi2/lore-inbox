Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbTETV07 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 17:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbTETV07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 17:26:59 -0400
Received: from magic-mail.adaptec.com ([208.236.45.100]:18580 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP id S261216AbTETV06
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 17:26:58 -0400
Date: Tue, 20 May 2003 15:40:00 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Stian Jordet <liste@jordet.nu>, linux-kernel@vger.kernel.org
Subject: Re: aic7(censored) compile error
Message-ID: <14830000.1053466799@aslan.btc.adaptec.com>
In-Reply-To: <1053465144.3102.8.camel@chevrolet.hybel>
References: <1053463220.3107.1.camel@chevrolet.hybel> <1053465144.3102.8.camel@chevrolet.hybel>
X-Mailer: Mulberry/3.0.3 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Hello,
>> 
>> Am I just blind, or haven't this been reported? Haven't been able to
>> compile 2.5.69 since bk4, I think. This is with gcc-3.3.
> 
> Hmm. I fixed this with changing line 767 to:

I believe this has already been fixed in TOT, but if not, I have
released the latest csets from my BK trees which address this and
other issues.  I'm still in the process of integrating some other
changes, so I will be release another update later this week.

http://people.FreeBSD.org/~gibbs/linux/SRC/

--
Justin

