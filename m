Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262707AbVA0TcC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262707AbVA0TcC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 14:32:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262708AbVA0Tba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 14:31:30 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14274 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262707AbVA0TbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 14:31:03 -0500
Message-ID: <41F9415C.1040204@pobox.com>
Date: Thu, 27 Jan 2005 14:30:36 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rick Bressler <rick@the-bresslers.com>
CC: kernel <linux-kernel@vger.kernel.org>
Subject: Re: Banging my head on SATA / ATAPI DMA problem.  Help?
References: <200501260357.j0Q3vw2X017393@colossus.loc>
In-Reply-To: <200501260357.j0Q3vw2X017393@colossus.loc>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rick Bressler wrote:
> ata_piix version 1.03
> ata_piix: combined mode detected


Combined mode == DMA impossible.

	Jeff


