Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261399AbSIPM0j>; Mon, 16 Sep 2002 08:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261401AbSIPM0i>; Mon, 16 Sep 2002 08:26:38 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:14319
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261399AbSIPM0i>; Mon, 16 Sep 2002 08:26:38 -0400
Subject: Re: DMA problems w/ PIIX3 IDE, 2.4.20-pre4-ac2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Florian Hinzmann <f.hinzmann@hamburg.de>
Cc: Andre Hedrick <andre@linux-ide.org>, linux-kernel@vger.kernel.org,
       Jan-Hinnerk Reichert <jan-hinnerk_reichert@hamburg.de>
In-Reply-To: <XFMail.20020916131706.f.hinzmann@hamburg.de>
References: <XFMail.20020916131706.f.hinzmann@hamburg.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 16 Sep 2002 13:33:15 +0100
Message-Id: <1032179595.1191.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-09-16 at 12:17, Florian Hinzmann wrote:
> kernel: hdb: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
> kernel: hdb: read_intr: error=0x10 { SectorIdNotFound }, LBAsect=97567071, high=5, lo
> kernel: hdb: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }

Which is the drive reporting a physical media error

