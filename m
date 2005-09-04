Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750914AbVIDPco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914AbVIDPco (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 11:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750907AbVIDPco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 11:32:44 -0400
Received: from mail.portrix.net ([212.202.157.208]:4572 "EHLO
	zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S1750846AbVIDPcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 11:32:43 -0400
Message-ID: <431B1348.6000209@ppp0.net>
Date: Sun, 04 Sep 2005 17:31:20 +0200
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Thunderbird/1.0.6 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: Linus Torvalds <torvalds@osdl.org>,
       =?ISO-8859-1?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>,
       git@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: empty patch-2.6.13-git? patches on ftp.kernel.org
References: <Pine.BSO.4.62.0508311527340.10416@rudy.mif.pg.gda.pl>	 <1125649389.6928.19.camel@baythorne.infradead.org>	 <Pine.LNX.4.58.0509020159110.3613@evo.osdl.org> <1125652914.6928.27.camel@baythorne.infradead.org>
In-Reply-To: <1125652914.6928.27.camel@baythorne.infradead.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:
> On Fri, 2005-09-02 at 02:00 -0700, Linus Torvalds wrote:
> 
>>Ahh. Please change that to
>>
>>        rm -rf tmp-empty-tree
>>        mkdir tmp-empty-tree
>>        cd tmp-empty-tree
>>        git-init-db
>>
>>because otherwise you'll almost certainly hit something else later
>>on..
> 
> 
> OK, done. 
> 

-git4 is again empty

 patch-2.6.13-git4.bz2      03-Sep-2005 02:03   14
[   ] patch-2.6.13-git4.bz2.sign 03-Sep-2005 02:03  248
[   ] patch-2.6.13-git4.gz       03-Sep-2005 02:03   20
[   ] patch-2.6.13-git4.gz.sign  03-Sep-2005 02:03  248
[   ] patch-2.6.13-git4.id       03-Sep-2005 02:01   41
[   ] patch-2.6.13-git4.log      03-Sep-2005 02:03  526K
[   ] patch-2.6.13-git4.sign     03-Sep-2005 02:03  248

-- 
Jan
