Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261592AbVB1NpY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261592AbVB1NpY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 08:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261596AbVB1NeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 08:34:19 -0500
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:56462 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S261592AbVB1Nd5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 08:33:57 -0500
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: Tejun Heo <htejun@gmail.com>
Subject: Re: [patch ide-dev 1/9] use struct ata_taskfile in ide_task_t
Date: Sun, 27 Feb 2005 17:40:51 +0100
User-Agent: KMail/1.7.1
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <Pine.GSO.4.58.0502241535240.13534@mion.elka.pw.edu.pl> <20050227045439.GB25723@htj.dyndns.org>
In-Reply-To: <20050227045439.GB25723@htj.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502271740.51670.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Thu, Feb 24, 2005 at 03:36:44PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > + tf->device = 0x40;
> 
>  Wouldn't ATA_LBA be clearer?

I will change it, thanks.
