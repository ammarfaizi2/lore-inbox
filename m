Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288754AbSADUdc>; Fri, 4 Jan 2002 15:33:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288755AbSADUdZ>; Fri, 4 Jan 2002 15:33:25 -0500
Received: from adsl-63-199-104-197.dsl.lsan03.pacbell.net ([63.199.104.197]:62725
	"HELO mail.theoesters.com") by vger.kernel.org with SMTP
	id <S288747AbSADUc2>; Fri, 4 Jan 2002 15:32:28 -0500
From: "Phil Oester" <kernel@theoesters.com>
To: <linux-kernel@vger.kernel.org>
Subject: 1gb RAM + 1gb SWAP + make -j bzImage = OOM
Date: Fri, 4 Jan 2002 12:32:27 -0800
Message-ID: <004b01c1955e$ecbc9190$6400a8c0@philxp>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2.4.17, I can't make -j bzImage without OOM kicking in.  Relatively
light .config here - bzImage compiles to less than 1mb.

Seems with 1 gb of RAM and swap, the box should be able to handle this
(box is dual P3 600 btw).  

Is this unreasonable?  How much RAM should it take to accomplish this???

-Phil Oester

