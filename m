Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268404AbUIWLRA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268404AbUIWLRA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 07:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268405AbUIWLRA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 07:17:00 -0400
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:23972 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S268404AbUIWLQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 07:16:58 -0400
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: tabris <tabris@tabris.net>
Subject: Re: undecoded slave?
Date: Thu, 23 Sep 2004 13:14:55 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <200409222357.39492.tabris@tabris.net>
In-Reply-To: <200409222357.39492.tabris@tabris.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200409231314.55547.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ use linux-ide@vger.kernel.org for ATA stuff ]

On Thursday 23 September 2004 05:57, tabris wrote:

> Probing IDE interface ide3...
> hdg: Maxtor 4D060H3, ATA DISK drive
> hdh: Maxtor 4D060H3, ATA DISK drive
> ide-probe: ignoring undecoded slave
> 
> Booted 2.6.9-rc2-mm2, and I no longer have an hdh. the error above seems 
> to be the only [stated] reason why.

Please send hdparm -I output for both drives.
