Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282950AbRK0VES>; Tue, 27 Nov 2001 16:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282956AbRK0VEL>; Tue, 27 Nov 2001 16:04:11 -0500
Received: from smtp-rt-12.wanadoo.fr ([193.252.19.60]:14831 "EHLO
	tamaris.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S282945AbRK0VC3>; Tue, 27 Nov 2001 16:02:29 -0500
Message-ID: <3C03FEA6.56038802@wanadoo.fr>
Date: Tue, 27 Nov 2001 21:59:18 +0100
From: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
Organization: Home PC
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.1-pre2 i686)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.1-pre2 unresolved symbols in nfs.o
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make modules_install ends with this error :

depmod: *** Unresolved symbols in
/lib/modules/2.5.1-pre2/kernel/fs/nfs/nfs.o
depmod: 	seq_escape
depmod: 	seq_printf

Pierre
-- 
------------------------------------------------
 Pierre Rousselet <pierre.rousselet@wanadoo.fr>
------------------------------------------------
