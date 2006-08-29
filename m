Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965049AbWH2P5o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965049AbWH2P5o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 11:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965043AbWH2P5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 11:57:44 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:8321 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S965046AbWH2P5n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 11:57:43 -0400
Message-ID: <44F463EA.1010908@ens-lyon.org>
Date: Tue, 29 Aug 2006 11:57:30 -0400
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zhu Yi <yi.zhu@intel.com>
Subject: Re: Linux v2.6.18-rc5
References: <Pine.LNX.4.64.0608272122250.27779@g5.osdl.org> <20060827231421.f0fc9db1.akpm@osdl.org>
In-Reply-To: <20060827231421.f0fc9db1.akpm@osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Sun, 27 Aug 2006 21:30:50 -0700 (PDT)
> Linus Torvalds <torvalds@osdl.org> wrote:
>
>   
>> Linux 2.6.18-rc5 is out there now
>>     
>
> (Reporters Bcc'ed: please provide updates)
>
> Serious-looking regressions include:
>   

I am having problems with ipw2200. It does not connect to my WPA access
point unless I help it (for instance by setting the ESSID with
iwconfig). It seems to be related to driver version 1.1.2. I had the
same problem when 1.1.2 was the latest external tarball.

I have been using 1.1.3 and 1.1.4 external tarballs without problems for
a while. Zhu Yi pushed 1.1.4 to netdev-2.6/wireless last week. Is there
any chance it could be pulled before 2.6.18?

Sorry for notifying so late in the release cycle...

Regards,
Brice

