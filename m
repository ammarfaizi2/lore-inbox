Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbTEYKRX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 06:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261743AbTEYKRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 06:17:23 -0400
Received: from mxout4.netvision.net.il ([194.90.9.27]:64931 "EHLO
	mxout4.netvision.net.il") by vger.kernel.org with ESMTP
	id S261741AbTEYKRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 06:17:19 -0400
Date: Sun, 25 May 2003 13:29:40 +0300
From: Nir Livni <nirl@cyber-ark.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Message-id: <E1298E981AEAD311A98D0000E89F45134B567F@ORCA>
MIME-version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-type: text/plain
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Where can i find some info about ext2 performance issues ?

I would like to know if library functions like stat (not fstat) , and open
(existing or new file) are affected by the number of files that exists in
1. the number of files in the file's directory
2. the number of files in the file system.

Are you aware of any improvements in latest kernels ?

Please CC me on your answer.

Thanks,
Nir
