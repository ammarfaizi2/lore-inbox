Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269524AbTCDULu>; Tue, 4 Mar 2003 15:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269526AbTCDULu>; Tue, 4 Mar 2003 15:11:50 -0500
Received: from 193-119.adsl5.netlojix.net ([207.71.193.119]:36997 "EHLO
	goby.lotspeich.org") by vger.kernel.org with ESMTP
	id <S269524AbTCDULu>; Tue, 4 Mar 2003 15:11:50 -0500
Date: Tue, 4 Mar 2003 12:22:18 -0800 (PST)
From: Erik Lotspeich <erikvcl@silcom.com>
X-X-Sender: <erik@goby.lotspeich.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: IrDA/PCMCIA CF conflict
Message-ID: <Pine.LNX.4.33.0303041219480.834-100000@goby.lotspeich.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a really strange device conflict that I'd like to report.  I'd be
happy to send more information if needed.

I have an IBM Thinkpad A21m with Linux 2.4.19.  Both the PCMCIA
IDE/Compact Flash adapter and IrDA (syncing to Palm) works perfectly --
separately.  If I boot with the CF/adapter in place, the IrDA does not
work.  If I simply remove the PCMCIA card and re-insert it, IrDA works
again.  If I boot without the PCMCIA CF adapter in place, then insert it
after using the IrDA, no trouble.

Is this a known issue?  If you need logs/configs, just let me know and
I'll send.

Thanks,

Erik.

