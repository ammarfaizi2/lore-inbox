Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267997AbRHFLvV>; Mon, 6 Aug 2001 07:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267999AbRHFLvL>; Mon, 6 Aug 2001 07:51:11 -0400
Received: from motgate.mot.com ([129.188.136.100]:50136 "EHLO motgate.mot.com")
	by vger.kernel.org with ESMTP id <S268001AbRHFLu5>;
	Mon, 6 Aug 2001 07:50:57 -0400
Message-Id: <3B6E84A1.1A13969@crm.mot.com>
Date: Mon, 06 Aug 2001 13:50:57 +0200
From: Emmanuel Varagnat <Emmanuel_Varagnat-AEV010@email.mot.com>
Reply-To: Emmanuel Varagnat-AEV010 
	  <Emmanuel_Varagnat-AEV010@email.mot.com>
Organization: Centre de Recherche de Motorola - Paris
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: ReiserFS file corruption
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Today, I crashed the kernel and after reboot the source file
I was working on, was completly unreadable. The size indicated
by 'ls' seems to be good but with bad data.

Is this behavior normal (because the FS seems correct) ?
The worst I hoped is loosing the last save, but not everything.

Must I patch to a newer version ?
I'm using a 2.4.3 version.

Thanks

-Manu

PS: Finally I greped the partition and recover my file.
