Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265787AbSKYWtM>; Mon, 25 Nov 2002 17:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265791AbSKYWtM>; Mon, 25 Nov 2002 17:49:12 -0500
Received: from imrelay-2.zambeel.com ([209.240.48.8]:23309 "EHLO
	imrelay-2.zambeel.com") by vger.kernel.org with ESMTP
	id <S265787AbSKYWtL>; Mon, 25 Nov 2002 17:49:11 -0500
Message-ID: <233C89823A37714D95B1A891DE3BCE5202AB19C3@xch-a.win.zambeel.com>
From: Manish Lachwani <manish@Zambeel.com>
To: "'Joao \"Alberto M. dos Reis \" \"(listas de discucao)'" 
	<lista@vudu.ath.cx>,
       lista do kernel <linux-kernel@vger.kernel.org>
Subject: RE: Network Load Balance
Date: Mon, 25 Nov 2002 14:56:00 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Did you try to work with ANS (Advanced Network Service) in the e1000 driver?
bThere is also a utility procfg that ca be used to configure this 

Thanks
Manish

-----Original Message-----
From: Joao "Alberto M. dos Reis " "(listas de discucao)
[mailto:lista@vudu.ath.cx]
Sent: Monday, November 25, 2002 2:44 PM
To: lista do kernel
Subject: Network Load Balance


There is any way to make 2 intel ethernet cards working as one, like the
Network Load Balance (NLB - Windows) in the Intel Ethernet adapters with
the Adaptive Load Balance feature on linux? 

I know that in windows it works, but in the linux? Anyone has any
ideias? 

Joao Reis.



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
