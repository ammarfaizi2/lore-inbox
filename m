Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262128AbVFWL1z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262128AbVFWL1z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 07:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262095AbVFWL1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 07:27:55 -0400
Received: from rudy.mif.pg.gda.pl ([153.19.42.16]:4512 "EHLO
	rudy.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S262128AbVFWL1x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 07:27:53 -0400
Date: Thu, 23 Jun 2005 13:28:06 +0200 (CEST)
From: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
To: Chris Wright <chrisw@osdl.org>
cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       stable@kernel.org
Subject: Re: Linux 2.6.12.1
In-Reply-To: <20050622220713.GV9046@shell0.pdx.osdl.net>
Message-ID: <Pine.BSO.4.62.0506231325150.19853@rudy.mif.pg.gda.pl>
References: <20050622220713.GV9046@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-906902408-1119526086=:19853"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-906902408-1119526086=:19853
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 22 Jun 2005, Chris Wright wrote:

> We (the -stable team) are announcing the release of the 2.6.12.1 kernel
> which has two security fixes.
>
> The diffstat and short summary of the fixes are below.
>
> I'll also be replying to this message with a copy of the patch between
> 2.6.12 and 2.6.12.1, as it is small enough to do so.
>
> The updated 2.6.12.y git tree can be found at:
> 	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/linux-2.6.12.y.git
> and can be browsed at the normal kernel.org git web browser:
> 	www.kernel.org/git/

Qlogic driver still is broken.
Patch with minimal set of changes for this was sended to k-l few days ago.
Is it something wrong with this fixes ?

kloczek
-- 
-----------------------------------------------------------
*Ludzie nie maj± problemów, tylko sobie sami je stwarzaj±*
-----------------------------------------------------------
Tomasz K³oczko, sys adm @zie.pg.gda.pl|*e-mail: kloczek@rudy.mif.pg.gda.pl*
--0-906902408-1119526086=:19853--
