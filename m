Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261561AbREUQ0P>; Mon, 21 May 2001 12:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261563AbREUQ0F>; Mon, 21 May 2001 12:26:05 -0400
Received: from hamachi.synopsys.com ([204.176.20.26]:63467 "EHLO
	hamachi.synopsys.com") by vger.kernel.org with ESMTP
	id <S261561AbREUQZy>; Mon, 21 May 2001 12:25:54 -0400
Message-ID: <3B094183.24148B9D@Synopsys.COM>
Date: Mon, 21 May 2001 18:25:39 +0200
From: Harald Dunkel <harri@synopsys.COM>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Giant disk on 2.2.17: Any concerns?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

For running some kind of database application (ClearCase 4.1) I would 
like to attach an external RAID array with 6*30GByte to a RedHat 6.2 
machine, using kernel 2.2.17. I don't expect huge files (maximum file 
size should be about 250MByte), but a lot of middle size files and 
millions of tiny files.

Will this work? 

Do you expect any problems with the partition table?


Many thanx in advance

Harri
