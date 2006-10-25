Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965215AbWJYUEt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965215AbWJYUEt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 16:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965213AbWJYUEt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 16:04:49 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:43231 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S964832AbWJYUEs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 16:04:48 -0400
From: Ismail Donmez <ismail@pardus.org.tr>
Organization: TUBITAK/UEKAE
To: James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: [GIT PATCH] SCSI fixes for 2.6.19-rc3
Date: Wed, 25 Oct 2006 23:04:35 +0300
User-Agent: KMail/1.9.5
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-scsi <linux-scsi@vger.kernel.org>
References: <1161792760.3816.6.camel@mulgrave.il.steeleye.com>
In-Reply-To: <1161792760.3816.6.camel@mulgrave.il.steeleye.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610252304.36098.ismail@pardus.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,
25 Eki 2006 Çar 19:12 tarihinde, James Bottomley şunları yazmıştı: 
[...]
> Tomonori FUJITA:
>   o replace u8 and u32 with __u8 and __u32 in scsi.h for user space

This patch obsoletes my  
scsi-scsih-protect-scsi_to_u32-function-by-ifdef-__kernel__.patch . It would 
be nicer if I got CC'd oh well.

Regards,
ismail
