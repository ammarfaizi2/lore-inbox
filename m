Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266708AbUHaGGk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266708AbUHaGGk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 02:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266721AbUHaGGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 02:06:40 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53636 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266708AbUHaGGd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 02:06:33 -0400
Message-ID: <41341556.2010306@pobox.com>
Date: Tue, 31 Aug 2004 02:06:14 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Tomita, Haruo" <haruo.tomita@toshiba.co.jp>
CC: Petr Sebor <petr@scssoft.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       petter.sundlof@findus.dhs.org, linux-kernel@vger.kernel.org
Subject: Re: Cannot enable DMA on SATA drive (SCSI-libsata, VIA SATA)
References: <7076215DFAA4574099E5CD59FE42226204FBC27B@pcssrv42.pcs.pc.ome.toshiba.co.jp>
In-Reply-To: <7076215DFAA4574099E5CD59FE42226204FBC27B@pcssrv42.pcs.pc.ome.toshiba.co.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomita, Haruo wrote:
> Combined mode can be set up by the SATA controller of ESB of Intel tip. 
> This mode is the mode which can use SATA and PATA simultaneously. 
> In ata_piix driver, when combined mode is specified, it does not work.


May I request, again, information on this.  In the current kernel you 
are the only one reporting this problem.

Does 2.6.9-rc1-bk work for you?

	Jeff


