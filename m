Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261382AbREMGyF>; Sun, 13 May 2001 02:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261383AbREMGxz>; Sun, 13 May 2001 02:53:55 -0400
Received: from [203.36.158.121] ([203.36.158.121]:4229 "EHLO
	piro.kabuki.openfridge.net") by vger.kernel.org with ESMTP
	id <S261382AbREMGxn>; Sun, 13 May 2001 02:53:43 -0400
Date: Sun, 13 May 2001 16:53:23 +1000
From: Daniel Stone <daniel@kabuki.openfridge.net>
To: linux-kernel@vger.kernel.org
Subject: [BUG] Vibra16XS and OSS/Free - static
Message-ID: <20010513165323.A13013@kabuki.openfridge.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
Organisation: Sadly lacking
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a Vibra16XS (yes, I know it sucks, but I can't afford better right
now), and, after about 15 minutes of mpg123 playing, it will suddenly go to
complete static. This can only be fixed by something closing the channel,
and then reopening it. I've also tried with large waves, only to get the
same result.

This is using 2.4.4-ac6, with only Netfilter hacks.

d

-- 
Daniel Stone
daniel@kabuki.openfridge.net
