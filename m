Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268685AbUHZLsT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268685AbUHZLsT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 07:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268776AbUHZLoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 07:44:25 -0400
Received: from c002781a.fit.bostream.se ([217.215.235.8]:19342 "EHLO
	mail.tnonline.net") by vger.kernel.org with ESMTP id S268779AbUHZLlH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 07:41:07 -0400
Date: Thu, 26 Aug 2004 13:43:54 +0200
From: Spam <spam@tnonline.net>
Reply-To: Spam <spam@tnonline.net>
X-Priority: 3 (Normal)
Message-ID: <1211039639.20040826134354@tnonline.net>
To: Wichert Akkerman <wichert@wiggy.net>
CC: Christer Weinigel <christer@weinigel.se>, Andrew Morton <akpm@osdl.org>,
       jra@samba.org, <torvalds@osdl.org>, <reiser@namesys.com>, <hch@lst.de>,
       <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <flx@namesys.com>, <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <20040826113332.GL2612@wiggy.net>
References: <Pine.LNX.4.58.0408251555070.17766@ppc970.osdl.org>
 <1453698131.20040826011935@tnonline.net>
 <20040825163225.4441cfdd.akpm@osdl.org>
 <20040825233739.GP10907@legion.cup.hp.com> <20040825234629.GF2612@wiggy.net>
 <1939276887.20040826114028@tnonline.net>
 <20040826024956.08b66b46.akpm@osdl.org> <839984491.20040826122025@tnonline.net>
 <m3llg2m9o0.fsf@zoo.weinigel.se> <1906433242.20040826133511@tnonline.net>
 <20040826113332.GL2612@wiggy.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> Previously Spam wrote:
>>   How  so?  The whole idea is that the underlaying OS that handles the
>>   copying  should  also  know  to  copy  everything, otherwise you can
>>   implement  everything  into  applications  and  just  skip the whole
>>   filesystem part.

> UNIX doesn't have a copy systemcall, applications copy the data
> manually.

  Oh, this is very unfortunate and should be a bigger issue to fix.

> Wichert.





