Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750811AbWFFRbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbWFFRbY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 13:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbWFFRbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 13:31:24 -0400
Received: from mail.lenk.info ([217.160.183.176]:61126 "EHLO mail.lenk.info")
	by vger.kernel.org with ESMTP id S1750735AbWFFRbW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 13:31:22 -0400
Message-ID: <4485BAF5.9060507@avona.com>
Date: Tue, 06 Jun 2006 19:27:17 +0200
From: Fabian Knittel <fabian.knittel@avona.com>
Organization: avona media GbR
User-Agent: Mail/News 1.5 (X11/20060228)
MIME-Version: 1.0
To: Milan Kupcevic <milan@physics.harvard.edu>
CC: Jeff Garzik <jgarzik@pobox.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, Eyal Lebedinsky <eyal@eyal.emu.id.au>,
       Stan Seibert <volsung@mailsnare.net>, linux-ide@vger.kernel.org,
       Christiaan den Besten <chris@scorpion.nl>
Subject: Re: [PATCH] sata_promise: Port enumeration order - SATA 150 TX4,
 SATA 300 TX4
References: <43FFAE3D.7010002@physics.harvard.edu> <44000036.7070403@eyal.emu.id.au> <011f01c639f9$8dc86bc0$3d64880a@speedy> <442DB29D.1010102@avona.com> <447CB9B4.50700@physics.harvard.edu>
In-Reply-To: <447CB9B4.50700@physics.harvard.edu>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Milan Kupcevic wrote:
> Please respond with this data:
> 
> - Your Promise SATA controller retail name
> - Chip label (PDCxxxxx)
> - PCI vendor and device code as you can get with "lspci -n"
> - Say if the controler has the new or the old wiring

We only have one card and it matches one of yours:

  Retail name: SATAII150 TX4
  Chip label: PDC40518  SATAII150
  Vendor-Device number: 105a:3d18 (rev 02)
  Wiring: NEW

Greetings, Fabian
-- 
avona media GbR      | Neureuter Str. 5-7   | D-76185 Karlsruhe
fon +49 721 53169901 | fax +49 721 53169904 | www.avona.com
