Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262559AbVC2HdA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262559AbVC2HdA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 02:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262575AbVC2H3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 02:29:46 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34755 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262559AbVC2HW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 02:22:58 -0500
Message-ID: <42490245.5020605@pobox.com>
Date: Tue, 29 Mar 2005 02:22:45 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
CC: linux-kernel@vger.kernel.org,
       Trivial Patch Monkey <trivial@rustcorp.com.au>
Subject: Re: [PATCH] typo fix in drivers/scsi/sata_svw.c
References: <200503271556.02600.eike-kernel@sf-tec.de>
In-Reply-To: <200503271556.02600.eike-kernel@sf-tec.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rolf Eike Beer wrote:
> Add missing brace.
> 
> Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>
> 
> --- linux-2.6.11/drivers/scsi/sata_svw.c	2005-03-21 11:41:58.000000000 +0100
> +++ linux-2.6.12-rc1/drivers/scsi/sata_svw.c	2005-03-27 15:50:38.000000000 +0200

Please send patches as directed:

[jgarzik@pretzel linux-2.6]$ head -7 drivers/scsi/sata_svw.c
/*
  *  sata_svw.c - ServerWorks / Apple K2 SATA
  *
  *  Maintained by: Benjamin Herrenschmidt <benh@kernel.crashing.org> and
  *                 Jeff Garzik <jgarzik@pobox.com>
  *                  Please ALWAYS copy linux-ide@vger.kernel.org
  *                  on emails.


