Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261228AbSIPIfh>; Mon, 16 Sep 2002 04:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261238AbSIPIfh>; Mon, 16 Sep 2002 04:35:37 -0400
Received: from mxintern.kundenserver.de ([212.227.126.201]:47816 "EHLO
	mxintern.kundenserver.de") by vger.kernel.org with ESMTP
	id <S261228AbSIPIfh>; Mon, 16 Sep 2002 04:35:37 -0400
User-Agent: Pan/0.11.1.90 (Unix)
From: "Michael" <mwohlwend@web.de>
To: linux-kernel@vger.kernel.org
Subject: via8235 support...
Date: Mon, 16 Sep 2002 10:40:34 +0200
Reply-To: mwohlwend@web.de
Message-Id: <E17qrQo-0005At-00@mxintern.kundenserver.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI,

is there allready support for the southbridge via8235? in the via82cxxx.c
file the chip is commented out with #ifdef FUTURE_BRIDGES ... #endif
I am not able to turn on dma mode for my hard discs, since the kernel say
unknown bridge. 
Is there a patch somewhere?

thanks
 michael
