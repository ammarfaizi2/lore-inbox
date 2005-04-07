Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262350AbVDGBJK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262350AbVDGBJK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 21:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262364AbVDGBJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 21:09:10 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:48771 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262350AbVDGBJH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 21:09:07 -0400
Subject: Re: non-free firmware in kernel modules, aggregation and unclear
	copyright notice.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Sven Luther <sven.luther@wanadoo.fr>, Matthew Wilcox <matthew@wil.cx>,
       Greg KH <greg@kroah.com>, Michael Poole <mdpoole@troilus.org>,
       debian-legal@lists.debian.org, debian-kernel@lists.debian.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jes Sorensen <jes@trained-monkey.org>, linux-acenic@sunsite.dk
In-Reply-To: <4251A7E8.6050200@pobox.com>
References: <20050404100929.GA23921@pegasos>
	 <87ekdq1xlp.fsf@sanosuke.troilus.org> <20050404141647.GA28649@pegasos>
	 <20050404175130.GA11257@kroah.com>
	 <20050404183909.GI18349@parcelfarce.linux.theplanet.co.uk>
	 <42519BCB.2030307@pobox.com> <20050404202706.GB3140@pegasos>
	 <4251A7E8.6050200@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1112835939.5835.70.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 07 Apr 2005 02:05:42 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-04-04 at 21:47, Jeff Garzik wrote:
> Bluntly, Debian is being a pain in the ass ;-)
> 
> There will always be non-free firmware to deal with, for key hardware.

Firmware being seperate does make a lot of sense. It isn't going away
but it doesn't generally belong in kernel now we have initrd and
firmware loaders.

Alan

