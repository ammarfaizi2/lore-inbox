Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbVILPjO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbVILPjO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 11:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbVILPjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 11:39:14 -0400
Received: from rudy.mif.pg.gda.pl ([153.19.42.16]:5503 "EHLO
	rudy.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S1750715AbVILPjM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 11:39:12 -0400
Date: Mon, 12 Sep 2005 17:39:10 +0200 (CEST)
From: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
To: "Tom 'spot' Callaway" <tcallawa@redhat.com>
cc: Aurora development <aurora-sparc-devel@lists.auroralinux.org>,
       linux-kernel@vger.kernel.org, "David S. Miller" <davem@redhat.com>,
       sparclinux@vger.kernel.org
Subject: Re: [Aurora-sparc-devel] [2.6.13-rc6-git13/sparc64]: Slab corruption
 (possible stack or buffer-cache corruption)
In-Reply-To: <1126536316.25031.66.camel@localhost.localdomain>
Message-ID: <Pine.BSO.4.62.0509121733380.5000@rudy.mif.pg.gda.pl>
References: <Pine.BSO.4.62.0509121604360.5000@rudy.mif.pg.gda.pl>
 <1126536316.25031.66.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-749312334-1126539550=:5000"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-749312334-1126539550=:5000
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 12 Sep 2005, Tom 'spot' Callaway wrote:
[..]
> We've been seeing this intermittently on arthur since Aurora 1.0 (2.4).

I see this secont time. Each time it was during dayly backup (dumping data 
on NFS volume).
Can I do something more ?

kloczek
-- 
-----------------------------------------------------------
*Ludzie nie maj± problemów, tylko sobie sami je stwarzaj±*
-----------------------------------------------------------
Tomasz K³oczko, sys adm @zie.pg.gda.pl|*e-mail: kloczek@rudy.mif.pg.gda.pl*
--0-749312334-1126539550=:5000--
