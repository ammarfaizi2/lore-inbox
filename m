Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262342AbTCIBcJ>; Sat, 8 Mar 2003 20:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262334AbTCIBcJ>; Sat, 8 Mar 2003 20:32:09 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:6016 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S262333AbTCIBcI>; Sat, 8 Mar 2003 20:32:08 -0500
Message-ID: <3E6A9BE4.D29D3E67@cinet.co.jp>
Date: Sun, 09 Mar 2003 10:41:56 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
X-Mailer: Mozilla 4.8C-ja  [ja/Vine] (X11; U; Linux 2.5.64-ac3-pc98smp i686)
X-Accept-Language: ja
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@steeleye.com>
CC: Mike Anderson <andmike@us.ibm.com>, Andries.Brouwer@cwi.nl,
       Patrick Mansfield <patmans@us.ibm.com>, linux-kernel@vger.kernel.org,
       SCSI Mailing List <linux-scsi@vger.kernel.org>, torvalds@transmeta.com
Subject: Re: [PATCH] scsi_error fix
References: <UTC200303072019.h27KJXX12872.aeb@smtp.cwi.nl> 
		<20030307211732.GA1148@beaverton.ibm.com> <1047075661.3444.27.camel@mulgrave>
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> This is against vanilla 2.5.64 (you have to take Andries work around out
> to see the fix in the BK version).

Thanks!
My old PC98 box with wd33c93 and SCSI-1 HD/CD re-works fine
after apllied you patch.
With cset-1.1099 patch, kernel can boot but mis detect SCSI-1
CD drive.

Regards,
Osamu Tomita
