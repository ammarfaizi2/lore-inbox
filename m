Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316826AbSFVSWp>; Sat, 22 Jun 2002 14:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316832AbSFVSWo>; Sat, 22 Jun 2002 14:22:44 -0400
Received: from port5.ds1-sby.adsl.cybercity.dk ([212.242.169.198]:63273 "EHLO
	trider-g7.fabbione.net") by vger.kernel.org with ESMTP
	id <S316826AbSFVSWo>; Sat, 22 Jun 2002 14:22:44 -0400
Message-ID: <3D14C06F.6010906@fabbione.net>
Date: Sat, 22 Jun 2002 20:22:39 +0200
From: Fabio Massimo Di Nitto <fabbione@fabbione.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020615 Debian/1.0.0-3
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: [FREEZE] 2.4.19-pre10 + Promise ATA100 tx2 ver 2.20
X-Enigmail-Version: 0.62.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
            probably was already discussed (I hope not).

I get a really bad freeze when there's heavy writing over the 2 x 120GB 
WD disks.
reading seems to be ok.

Since Im really not an expert in setting up IDE stuff the only things I 
can say is that
there's no OOPS or error or nothing on the screen/log.

The freeze is reproducible both with 2.4.19-pre10 and 2.4.18.
In my config I have tryed with/without DMA/Promise special options and 
different combinations
of them with no results.

I will be glad to offer more info and help if someone can kindly tell me 
how to debug
this. If it's needed I can consider providing access to the machine.

Thanks
Fabio


