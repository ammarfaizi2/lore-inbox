Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263585AbUFNRGT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263585AbUFNRGT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 13:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263616AbUFNRGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 13:06:19 -0400
Received: from mail3.epfl.ch ([128.178.50.19]:26381 "HELO mail3.epfl.ch")
	by vger.kernel.org with SMTP id S263585AbUFNRFW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 13:05:22 -0400
Date: Mon, 14 Jun 2004 19:05:19 +0200
From: Gregoire Favre <Gregoire.Favre@freesurf.ch>
To: linux-kernel@vger.kernel.org
Subject: Partition change since 2.6.7-rc3 ?
Message-ID: <20040614170519.GB10158@magma.epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I posted a problem with 2.6.7-rc3 :

http://marc.theaimsgroup.com/?l=linux-kernel&m=108704073817936&w=2
which I thought was about usb, but I now think it's about partition as I
got:

Jun 12 13:26:25 greg kernel:  sdg: unknown partition table

While under 2.6.7-rc2 I have :

Jun 12 13:40:01 greg kernel:  sdg: sdg1 sdg2 sdg3 sdg4

I have just tried 2.6.7-rc3-mm2 which gave me the same result...

All my SCSI and IDE discs works perfectly, even my 8-1 cards readers
works, only problem is with my apacer Steno 512Mb.

Any hope to have it fixed ?

Thank to CC to me as I am not on this ml :-)

-- 
	Grégoire Favre
________________________________________________________________________
http://magma.epfl.ch/greg ICQ:16624071 mailto:Gregoire.Favre@freesurf.ch
