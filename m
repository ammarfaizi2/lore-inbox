Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261636AbVCIQkw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261636AbVCIQkw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 11:40:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261658AbVCIQkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 11:40:52 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:10890 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261636AbVCIQkm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 11:40:42 -0500
Subject: Re: Linux 2.6.11-ac1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: CaT <cat@zip.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <58cb370e05030908267f0fadbe@mail.gmail.com>
References: <1110231261.3116.90.camel@localhost.localdomain>
	 <20050309072646.GG1811@zip.com.au>
	 <58cb370e05030908267f0fadbe@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1110386321.3116.196.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 09 Mar 2005 16:38:43 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-03-09 at 16:26, Bartlomiej Zolnierkiewicz wrote:
> It can be merged if somebody fix it to always force controller into
> non-RAID mode and remove RAID mode support (which currently
> does nothing more besides complicating the driver and making special
> commands unusable).

Incorrect

