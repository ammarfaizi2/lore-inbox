Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbTJ0Jtx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 04:49:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbTJ0Jtw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 04:49:52 -0500
Received: from totor.bouissou.net ([82.67.27.165]:9349 "EHLO
	totor.bouissou.net") by vger.kernel.org with ESMTP id S261262AbTJ0JtR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 04:49:17 -0500
Content-Type: text/plain;
  charset="iso-8859-2"
From: Michel Bouissou <michel@bouissou.net>
Organization: Completely disorganized
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: Patch for Promise PDC20276
Date: Mon, 27 Oct 2003 10:49:15 +0100
User-Agent: KMail/1.4.3
Cc: abrutschy@xylon.de, linux-kernel@vger.kernel.org
References: <200310271009.13054@totor.bouissou.net> <200310271049.32819.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200310271049.32819.bzolnier@elka.pw.edu.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200310271049.15348@totor.bouissou.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Lundi 27 Octobre 2003 10:49, Bartlomiej Zolnierkiewicz a écrit :
>
> This was discussed few times before.
> Just enable "Special FastTrak feature" (overriding BIOS) config option.

Uh. I may have misunderstood, but I understood that using this option would 
activate the controller's hardware RAID feature, which I don't want.

I need to use the controller as a normal, non-RAID, IDE controller (and if 
ever if was setup as hardware RAID, I'm afraid it would destroy my data..)

Cheers.

-- 
Michel Bouissou <michel@bouissou.net> OpenPGP ID 0xDDE8AC6E
