Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266648AbUHIO06@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266648AbUHIO06 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 10:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266626AbUHIOZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 10:25:36 -0400
Received: from hibernia.jakma.org ([212.17.55.49]:21135 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S266627AbUHIOVy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 10:21:54 -0400
Date: Mon, 9 Aug 2004 15:21:24 +0100 (IST)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@fogarty.jakma.org
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
cc: James.Bottomley@steeleye.com, axboe@suse.de, linux-kernel@vger.kernel.org,
       mj@ucw.cz
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
In-Reply-To: <200408091413.i79EDt9L010562@burner.fokus.fraunhofer.de>
Message-ID: <Pine.LNX.4.60.0408091519440.2622@fogarty.jakma.org>
References: <200408091413.i79EDt9L010562@burner.fokus.fraunhofer.de>
X-NSA: arafat al aqsar jihad musharef jet-A1 avgas ammonium qran inshallah allah al-akbar martyr iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas british airways washington
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811072-387445850-1092061284=:2622"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811072-387445850-1092061284=:2622
Content-Type: TEXT/PLAIN; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 9 Aug 2004, Joerg Schilling wrote:

> Then I would love to see a demo that uses /dev/sg* with a ATAPI drive
> using DMA for all related sector sizes.

Hmm, you'd have to wait for Jeff Garzik to finish ATAPI support in 
libata and address any issues with him.

Anyway, I was just commenting on the device naming issue.

> Jörg

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
Death is only a state of mind.

Only it doesn't leave you much time to think about anything else.
---1463811072-387445850-1092061284=:2622--
