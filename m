Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269012AbUIQQMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269012AbUIQQMa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 12:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269015AbUIQQL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 12:11:29 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:33693 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S268993AbUIQQDc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 12:03:32 -0400
Date: Fri, 17 Sep 2004 18:01:51 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Jon Mason <jdmason@us.ibm.com>
Cc: Hans-Frieder Vogt <hfvogt@arcor.de>, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com, netdev@oss.sgi.com
Subject: Re: 2.6.9-rc1-bk11+ and 2.6.9-rc1-mm3,4 r8169: freeze during boot (FIX included)
Message-ID: <20040917160151.GA29337@electric-eye.fr.zoreil.com>
References: <200409130035.50823.hfvogt@arcor.de> <20040916070211.GA32592@electric-eye.fr.zoreil.com> <200409161320.16526.jdmason@us.ltcfwd.linux.ibm.com> <200409171043.21772.jdmason@us.ltcfwd.linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409171043.21772.jdmason@us.ltcfwd.linux.ibm.com>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Mason <jdmason@us.ibm.com> :
[...]
> Before I make any sweeping comments about the performance on ppc64, I should 
> probably do some more tests.  I'll have to get back to you regarding that.
> 
> Would you like me to run the "Config2" patch on my amd64 system?

Please do. If I read you correctly, 2.6.9-rc2-bkX works (more or less)
on both your ppc64 and amd64 systems, right ?

--
Ueimor
