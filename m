Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280056AbRLBPxD>; Sun, 2 Dec 2001 10:53:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280029AbRLBPwx>; Sun, 2 Dec 2001 10:52:53 -0500
Received: from relay-2v.club-internet.fr ([194.158.96.113]:27119 "HELO
	relay-2v.club-internet.fr") by vger.kernel.org with SMTP
	id <S280114AbRLBPwm>; Sun, 2 Dec 2001 10:52:42 -0500
Message-ID: <3C0A4E56.1070409@freesurf.fr>
Date: Sun, 02 Dec 2001 16:52:54 +0100
From: Kilobug <kilobug@freesurf.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6+) Gecko/20011130
X-Accept-Language: fr-fr, fr, en
MIME-Version: 1.0
To: lkm <linux-kernel@vger.kernel.org>
Subject: [2.5.1-pre5] Unresolved symbols in nfs module
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make modules_install:

if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.1-pre5; fi
depmod: *** Unresolved symbols in 
/lib/modules/2.5.1-pre5/kernel/fs/nfs/nfs.o
depmod:         seq_escape
depmod:         seq_printf

-- 
  ** Gael Le Mignot, Ing3 EPITA, Coder of The Kilobug Team **
Home Mail : kilobug@freesurf.fr          Work Mail : le-mig_g@epita.fr
GSM       : 06.71.47.18.22 (in France)   ICQ UIN   : 7299959
Web       : http://kilobug.freesurf.fr or http://drizzt.dyndns.org

"Software is like sex it's better when it's free.", Linus Torvalds

