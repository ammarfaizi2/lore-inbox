Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267259AbUHSTBw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267259AbUHSTBw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 15:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267269AbUHSTBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 15:01:51 -0400
Received: from the-village.bc.nu ([81.2.110.252]:5765 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267259AbUHSTBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 15:01:44 -0400
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kernel@wildsau.enemy.org, fsteiner-mail@bio.ifi.lmu.de,
       diablod3@gmail.com
In-Reply-To: <4124D042.nail85A1E3BQ6@burner>
References: <200408041233.i74CX93f009939@wildsau.enemy.org>
	 <4124BA10.6060602@bio.ifi.lmu.de>
	 <1092925942.28353.5.camel@localhost.localdomain>
	 <200408191800.56581.bzolnier@elka.pw.edu.pl>
	 <4124D042.nail85A1E3BQ6@burner>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092938348.28370.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 19 Aug 2004 18:59:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-08-19 at 17:07, Joerg Schilling wrote:
> Cdrtools is is code freeze state. This is why I say the best idea is to remove 
> this interface change from the current Linux kernel and wait until there will
> be new cdrtools alpha for 2.02 releases. These alpha could get support for uid
> switching. If Linux then would again switch the changes on, it makes sense.

While Sun did spend a year refusing to fix security holes I found -  for
"compatibility reasons" - long ago back when I was a sysadmin at NTL,
the Linux world does not work that way.

Alan

