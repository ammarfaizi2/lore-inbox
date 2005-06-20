Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261154AbVFTKgO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbVFTKgO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 06:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbVFTKf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 06:35:26 -0400
Received: from rudy.mif.pg.gda.pl ([153.19.42.16]:6167 "EHLO
	rudy.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S261153AbVFTKdf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 06:33:35 -0400
Date: Mon, 20 Jun 2005 12:33:49 +0200 (CEST)
From: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: Chris Wright <chrisw@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Q: qla23xxx and lpfc (Was: Re: [GIT PATCH] SCSI updates for 2.6.12)
In-Reply-To: <1119260140.6099.0.camel@mulgrave>
Message-ID: <Pine.BSO.4.62.0506201217410.19853@rudy.mif.pg.gda.pl>
References: <1119103586.4984.5.camel@mulgrave>  <20050618141636.GA4112@infradead.org>
  <20050618174558.GX9153@shell0.pdx.osdl.net> <1119260140.6099.0.camel@mulgrave>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-1189960872-1119263629=:19853"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1189960872-1119263629=:19853
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 20 Jun 2005, James Bottomley wrote:

> On Sat, 2005-06-18 at 10:45 -0700, Chris Wright wrote:
>> Sure, if it's seriously broken w/out send it to stable@kernel.org,
>> and we'll queue it up.
>
> It should be here:
>
> rsync://www.parisc-linux.org/~jejb/git/scsi-rc-fixes-2.6.git
>
> That's the same patch that's merged now.

Included in vanilla 2.6.12 qla23xxx 8.00.02b5 is for me unuseable (fails 
on scaning luns and oopses on array controler reset) on x86_64 with
qla2300 and for me works only version 8.01.00b2.
Is it will be possible include this version in official tree ?

Also is it will be possible include Emulex lpfc driver to official tree ?

kloczek
-- 
-----------------------------------------------------------
*Ludzie nie maj± problemów, tylko sobie sami je stwarzaj±*
-----------------------------------------------------------
Tomasz K³oczko, sys adm @zie.pg.gda.pl|*e-mail: kloczek@rudy.mif.pg.gda.pl*
--0-1189960872-1119263629=:19853--
