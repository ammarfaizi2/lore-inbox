Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030356AbVIVOB6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030356AbVIVOB6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 10:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030357AbVIVOB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 10:01:57 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:8846 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030356AbVIVOB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 10:01:57 -0400
Subject: Re: [PATCH 2.6.13] drivers/ide: Enable basic VIA VT6410 IDE
	functionality
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Robert Kesterson <robertk@robertk.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <op.sxg2dxd5wc4mme@new.robertk.com>
References: <op.sxg2dxd5wc4mme@new.robertk.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 22 Sep 2005 15:28:17 +0100
Message-Id: <1127399297.18840.92.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-09-21 at 16:38 -0500, Robert Kesterson wrote:
> This patch enables plain IDE functionality on the VIA VT6410 IDE controller
> (such as used on the Asus P4P800 Deluxe motherboard). 

Mathias Kretschmer posted a patch several months ago, and Daniel Drake
reposted it on August 30th if you check the archive. Bartlomiej was
asked to respond to/merge it but if he responded I didn't see it so it
was probably a private reply.

You can pull it from the Gentoo tree and it'll drop into other vendor
trees cleanly.

Alan

