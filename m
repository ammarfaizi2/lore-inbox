Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265446AbTCCPFk>; Mon, 3 Mar 2003 10:05:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265339AbTCCPFk>; Mon, 3 Mar 2003 10:05:40 -0500
Received: from 195-219-31-160.sp-static.linix.net ([195.219.31.160]:46209 "EHLO
	r2d2.office") by vger.kernel.org with ESMTP id <S265446AbTCCPFj>;
	Mon, 3 Mar 2003 10:05:39 -0500
Message-ID: <3E637196.8030708@walrond.org>
Date: Mon, 03 Mar 2003 15:15:34 +0000
From: Andrew Walrond <andrew@walrond.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5-bk menuconfig format problem
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just done a pull and now the first entry of make menuconfig is:

  [*] Support for paging of anonymous memory

It shouldn't really be there, should it?

Andrew Walrond

