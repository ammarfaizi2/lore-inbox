Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314558AbSEFQZe>; Mon, 6 May 2002 12:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314562AbSEFQZd>; Mon, 6 May 2002 12:25:33 -0400
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:57054 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S314558AbSEFQZc>; Mon, 6 May 2002 12:25:32 -0400
Message-ID: <3CD6AE7A.FBEB5726@delusion.de>
Date: Mon, 06 May 2002 18:25:30 +0200
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.8 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Ext3 errors with 2.4.18
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

With Linux 2.4.18, I'm getting multiple of the following error:

EXT3-fs error (device ide0(3,2)): ext3_readdir: bad entry in directory #1966094:
rec_len % 4 != 0 - offset=0, inode=3180611420, rec_len=53134, name_len=138

Can someone decipher this?

Regards,
-Udo.
