Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272773AbTG3GHO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 02:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272774AbTG3GHO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 02:07:14 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:35744 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id S272773AbTG3GHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 02:07:13 -0400
Message-Id: <5.1.0.14.2.20030730080726.00a797e0@pop.t-online.de>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 30 Jul 2003 08:08:29 +0200
To: linux-kernel@vger.kernel.org
From: margitsw@t-online.de (Margit Schubert-While)
Subject: Re: Linux 2.4.22-pre9
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Seen: false
X-ID: EG4vGYZArePJ5t4eOMT-fHuKGEXyk0tZ24k4PcEw3isdytCx1cMnQy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.22-pre9; fi
depmod: *** Unresolved symbols in 
/lib/modules/2.4.22-pre9/kernel/drivers/net/wan/comx.o
depmod:         proc_get_inode

Still not fixed :-)

Margit 

