Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266585AbUHIOGy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266585AbUHIOGy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 10:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266590AbUHIOGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 10:06:53 -0400
Received: from hibernia.jakma.org ([212.17.55.49]:20870 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S266585AbUHIOGp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 10:06:45 -0400
Date: Mon, 9 Aug 2004 15:03:35 +0100 (IST)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@fogarty.jakma.org
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
cc: James.Bottomley@steeleye.com, axboe@suse.de, linux-kernel@vger.kernel.org,
       mj@ucw.cz
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
In-Reply-To: <200408091205.i79C5mW3009645@burner.fokus.fraunhofer.de>
Message-ID: <Pine.LNX.4.60.0408091501400.2622@fogarty.jakma.org>
References: <200408091205.i79C5mW3009645@burner.fokus.fraunhofer.de>
X-NSA: arafat al aqsar jihad musharef jet-A1 avgas ammonium qran inshallah allah al-akbar martyr iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas british airways washington
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811072-328057600-1092060215=:2622"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811072-328057600-1092060215=:2622
Content-Type: TEXT/PLAIN; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 9 Aug 2004, Joerg Schilling wrote:

>> dependent on topology at all, they depend on some other topology
>> independent identifier, eg FC UUID.
>
> Don't comment things you don't ever try.....
>
> Of course, ATAPI devices on Solaris are handled by the same
> target drivers as e.g. those on 50 pin cables.

Yes ATAPI is.

> The ATA driver is implemented the way one would expect it by acting 
> as a SCSI HBA.

Yes, as does libata on Linux.

> Jörg

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
Events are not affected, they develop.
 		-- Sri Aurobindo
---1463811072-328057600-1092060215=:2622--
