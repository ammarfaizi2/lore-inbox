Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269583AbRHMAD0>; Sun, 12 Aug 2001 20:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269589AbRHMADQ>; Sun, 12 Aug 2001 20:03:16 -0400
Received: from inet-mail3.oracle.com ([148.87.2.203]:9114 "EHLO
	inet-mail3.oraclecorp.com") by vger.kernel.org with ESMTP
	id <S269583AbRHMADE>; Sun, 12 Aug 2001 20:03:04 -0400
Message-ID: <3B7719BF.C6DC958A@oracle.com>
Date: Mon, 13 Aug 2001 02:05:19 +0200
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Support Services
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.9-pre1 unresolved symbols in fat.o/smbfs.o
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

depmod: *** Unresolved symbols in /lib/modules/2.4.9-pre1/kernel/fs/fat/fat.o
depmod: 	generic_file_llseek
depmod: *** Unresolved symbols in /lib/modules/2.4.9-pre1/kernel/fs/smbfs/smbfs.o
depmod: 	generic_file_llseek
 
--alessandro

 "this is no time to get cute, it's a mad dog's promenade
  so walk tall, or baby don't walk at all"
                (Bruce Springsteen, 'New York City Serenade')
