Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129079AbQKOAxg>; Tue, 14 Nov 2000 19:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129130AbQKOAx0>; Tue, 14 Nov 2000 19:53:26 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:36871
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S129079AbQKOAxP>; Tue, 14 Nov 2000 19:53:15 -0500
Date: Tue, 14 Nov 2000 16:22:05 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: LA Walsh <law@sgi.com>
cc: Andries Brouwer <aeb@veritas.com>, lkml <linux-kernel@vger.kernel.org>
Subject: RE: IDE0 /dev/hda performance hit in 2217 on my HW - more info -
 maybe extended partitions
In-Reply-To: <NBBBJGOOMDFADJDGDCPHOEJLCJAA.law@sgi.com>
Message-ID: <Pine.LNX.4.10.10011141620270.13158-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linda,

Are you having variable transfer rates based on the zone access point?
If this is the case it is correctly reporting slow on the ID of the LBA
range v/s the OD on the media.

Regards,

Andre Hedrick
CTO Timpanogas Research Group
EVP Linux Development, TRG
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
