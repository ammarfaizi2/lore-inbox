Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264610AbSLVOWt>; Sun, 22 Dec 2002 09:22:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264620AbSLVOWt>; Sun, 22 Dec 2002 09:22:49 -0500
Received: from smtp-out-2.wanadoo.fr ([193.252.19.254]:16628 "EHLO
	mel-rto2.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S264610AbSLVOWt>; Sun, 22 Dec 2002 09:22:49 -0500
Message-ID: <3E05CD6C.FF9BF954@wanadoo.fr>
Date: Sun, 22 Dec 2002 15:34:20 +0100
From: rmkml <rmkml@wanadoo.fr>
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.21-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Pbs network card PCnet/FAST 79C971
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Im use kernel 2.4.21pre2,

and I a pbs on my network card ...

I don't use 100BaseTX / Full-duplex !
I don't use 100BaseTX / Half-duplex !
I don't use 10BaseT / Full-duplex !

I use only mode 10BaseT / Half-duplex ...

I compile and run "mii" and don't Fix speed ! (100BaseTX/full-duplex)

My version of pcnet32.c is 1.27b.

Could any help ?

My card in use on very old pc box (HP Kayak Pentium II - 400Mhz)

Regards



