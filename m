Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275724AbRI0AyM>; Wed, 26 Sep 2001 20:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275725AbRI0AyC>; Wed, 26 Sep 2001 20:54:02 -0400
Received: from norma.kjist.ac.kr ([203.237.41.18]:10633 "EHLO
	norma.kjist.ac.kr") by vger.kernel.org with ESMTP
	id <S275724AbRI0Axv>; Wed, 26 Sep 2001 20:53:51 -0400
Message-ID: <3BB27912.7090303@norma.kjist.ac.kr>
Date: Thu, 27 Sep 2001 09:55:46 +0900
From: Maintaniner on duty <hugh@norma.kjist.ac.kr>
User-Agent: Mozilla/5.0 (X11; U; Linux alpha; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: linux-2.4.10aa1 not umounting the root file system during shut-down
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know whether this bug is a problem of 2.4.10 or its aa1 or
the "umount" program under SuSE-7.2 for Intel.
But things changed between 2.4.10pre5 and 2.4.10aa1.

During the boot, the root file system is always picked up
by "fsck" as unmounted cleanly.

Thank you.

Regards,

Hugh


