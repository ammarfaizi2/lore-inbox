Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282949AbRK0VII>; Tue, 27 Nov 2001 16:08:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282959AbRK0VH6>; Tue, 27 Nov 2001 16:07:58 -0500
Received: from inet-mail4.oracle.com ([148.87.2.204]:20610 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id <S282949AbRK0VHy>; Tue, 27 Nov 2001 16:07:54 -0500
Message-ID: <3C040117.1312599D@oracle.com>
Date: Tue, 27 Nov 2001 22:09:43 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Support Services
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.16-i8k i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.1-pre2: modular nfs.o has unresolved symbols
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.1-pre2; fi
depmod: *** Unresolved symbols in /lib/modules/2.5.1-pre2/kernel/fs/nfs/nfs.o
depmod: 	seq_escape
depmod: 	seq_printf

--alessandro

 "we live as we dream alone / to break the spell we mix with the others
  we were not born in isolation / but sometimes it seems that way"
     (R.E.M., live intro to 'World Leader Pretend')
