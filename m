Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129415AbQLRVzb>; Mon, 18 Dec 2000 16:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129697AbQLRVzU>; Mon, 18 Dec 2000 16:55:20 -0500
Received: from zmamail02.zma.compaq.com ([161.114.64.102]:62727 "HELO
	zmamail02.zma.compaq.com") by vger.kernel.org with SMTP
	id <S129415AbQLRVzI>; Mon, 18 Dec 2000 16:55:08 -0500
Message-ID: <3A3E8096.3010606@zk3.dec.com>
Date: Mon, 18 Dec 2000 16:24:38 -0500
From: Peter Rival <frival@zk3.dec.com>
Organization: Tru64 QMG Performance Engineering
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22smp i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, axp-list <axp-list@redhat.com>
Subject: QLogicFC problems with 2.4.x?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

   I was just lent a QLogic ISP2200 FC adapter and have been having a 
bear of a time trying to get it to work on my Alpha ES40 and GS80.  I've 
tried both the qlogicfc (with standard kernel) and qla2x00 (from QLogic 
and Compaq) driver both built-in and as modules but neither of them are 
working.  Has anyone had success with later (I'm using 2.4.0-test11) 2.4 
kernels and the QLogic FC adapter?  I'm currently plugged into a Brocade 
switch (Plaides I, I believe) which is also attached to two pair of 
HSG80 FC RAID controllers.  AFAIK, the 2200 is supposed to work with an 
FC fabric, so this should work, right?  Can anyone offer any 
assistance?  Thanks!

  - Pete

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
