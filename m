Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030247AbWARJS3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030247AbWARJS3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 04:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030294AbWARJS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 04:18:29 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:3747 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030247AbWARJS2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 04:18:28 -0500
Subject: Re: amd64 cdrom access locks system
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christer =?ISO-8859-1?Q?B=E4ckstr=F6m?= 
	<cbackstrom@letterboxes.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43CD8C64.4080909@letterboxes.org>
References: <S1750841AbWAQXWc/20060117232242Z+104@vger.kernel.org>
	 <43CD8C64.4080909@letterboxes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Date: Wed, 18 Jan 2006 09:18:02 +0000
Message-Id: <1137575882.25819.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2006-01-18 at 01:31 +0100, Christer Bäckström wrote:
> ALi Corporation M5229 IDE (rev c7)
> 
> The cd-writer locks up if the DMA is enabled, as above. But the drive is 
> usable if it is disabled.

Under what circumstances does the writer lock - when writing or in
general ?


