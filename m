Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267150AbUBSJ4q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 04:56:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267165AbUBSJ4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 04:56:46 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:62880 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S267150AbUBSJ4o convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 04:56:44 -0500
Subject: Re: sys_tux stolen @s390 in 2.6
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, Pete Zaitcev <zaitcev@redhat.com>
X-Mailer: Lotus Notes Release 5.0.11   July 24, 2002
Message-ID: <OF40839756.8606BD1D-ON41256E3F.00366EED-41256E3F.00369D21@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Thu, 19 Feb 2004 10:56:31 +0100
X-MIMETrack: Serialize by Router on D12ML016/12/M/IBM(Release 6.0.2CF2|July 23, 2003) at
 19/02/2004 10:56:35
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org






Hi Arnd,

> In my copy of tux-3.2.13, the number 242 is used correctly. That number
> is the one that is reserved in the official linux sources. Martin
> allocated it exactly one year ago when I sent the patch enabling
> s390 in tux to Florian La Roche <laroche@redhat.com>.
>
> If you have a really old version of the tux sources, there might
> be the fallback to number 222 still there (which is a pretty dumb
> idea, btw).

Ahh, this explains it. I was already worried that I have misplaced
some mail that reserved #222 for tux. The official number is indeed
#242.

blue skies,
   Martin

Linux/390 Design & Development, IBM Deutschland Entwicklung GmbH
Schönaicherstr. 220, D-71032 Böblingen, Telefon: 49 - (0)7031 - 16-2247
E-Mail: schwidefsky@de.ibm.com


