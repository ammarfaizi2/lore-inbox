Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268470AbUHZJsG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268470AbUHZJsG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 05:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268163AbUHZJjD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 05:39:03 -0400
Received: from c002781a.fit.bostream.se ([217.215.235.8]:18573 "EHLO
	mail.tnonline.net") by vger.kernel.org with ESMTP id S268378AbUHZJhq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 05:37:46 -0400
Date: Thu, 26 Aug 2004 11:40:28 +0200
From: Spam <spam@tnonline.net>
Reply-To: Spam <spam@tnonline.net>
X-Priority: 3 (Normal)
Message-ID: <1939276887.20040826114028@tnonline.net>
To: Wichert Akkerman <wichert@wiggy.net>
CC: Jeremy Allison <jra@samba.org>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, <reiser@namesys.com>, <hch@lst.de>,
       <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <flx@namesys.com>, <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <20040825234629.GF2612@wiggy.net>
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com>
 <20040825152805.45a1ce64.akpm@osdl.org> <112698263.20040826005146@tnonline.net>
 <Pine.LNX.4.58.0408251555070.17766@ppc970.osdl.org>
 <1453698131.20040826011935@tnonline.net>
 <20040825163225.4441cfdd.akpm@osdl.org>
 <20040825233739.GP10907@legion.cup.hp.com> <20040825234629.GF2612@wiggy.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> Previously Jeremy Allison wrote:
>> Multiple-data-stream files are something we should offer, definately (IMHO).
>> I don't care how we do it, but I know it's something we need as application
>> developers.

> Aside from samba, is there any other application that has a use for
> them?

  Yes,  for  example  documents,  image  files  etc. The multiple data
  streams  can  contain thumbnails, info about who is editing the file
  (useful for networked files) etc. Could be used for version handling
  and much more.

  Also, just because we do not see all the benefits right now, doesn't
  mean there won't be any.

  ~S

> Wichert.





