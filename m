Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267157AbTBLPTr>; Wed, 12 Feb 2003 10:19:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267176AbTBLPTr>; Wed, 12 Feb 2003 10:19:47 -0500
Received: from mta02-svc.ntlworld.com ([62.253.162.42]:12186 "EHLO
	mta02-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S267157AbTBLPTq>; Wed, 12 Feb 2003 10:19:46 -0500
From: "Alvaro  Barbosa G." <alvaro.barbosa-g@ntlworld.com>
To: linux-kernel@vger.kernel.org
Subject: linux-2.5.60 against phoebe-kernel-2.4.20-2.41
Date: Wed, 12 Feb 2003 15:29:38 +0000
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302121529.38808.alvaro.barbosa-g@ntlworld.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Silly question, is it possible to compile linux-2.5.60 against phoebe 
kernel-2.4.20-2.41?
When creating bzImage, gets:

make bzImage 2>bzI_err
ld:arch/i386/kernel/.tmp_time.ver:1: parse error
make[1]: *** [arch/i386/kernel/time.o] Error 1
make: *** [arch/i386/kernel] Error 2

Thanks,
alvaro
