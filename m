Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932532AbVLETbn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932532AbVLETbn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 14:31:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932539AbVLETbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 14:31:43 -0500
Received: from attila.bofh.it ([213.92.8.2]:18123 "EHLO attila.bofh.it")
	by vger.kernel.org with ESMTP id S932535AbVLETbm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 14:31:42 -0500
Date: Mon, 5 Dec 2005 19:28:56 +0100
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Kay Sievers <kay.sievers@vrfy.org>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: ide: MODALIAS support for autoloading of ide-cd, ide-disk, ...
Message-ID: <20051205182856.GB8827@wonderland.linux.it>
References: <20051203172418.GA12297@vrfy.org> <58cb370e0512050024s647fdc5eg8d0c2e60dd7867dd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58cb370e0512050024s647fdc5eg8d0c2e60dd7867dd@mail.gmail.com>
User-Agent: Mutt/1.5.11
From: md@Linux.IT (Marco d'Itri)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 05, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> Looks fine but what about ide-scsi driver and ide_optical media?
The Debian hotplug script, which does the same thing, does not know
about these modules and nobody ever complained, so if some support is
needed it can be added later.

(And ide-scsi is dead anyway...)

-- 
ciao,
Marco
