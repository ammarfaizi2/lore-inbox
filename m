Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310137AbSCFT24>; Wed, 6 Mar 2002 14:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310138AbSCFT2q>; Wed, 6 Mar 2002 14:28:46 -0500
Received: from paloma14.e0k.nbg-hannover.de ([62.181.130.14]:24032 "HELO
	paloma14.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S310137AbSCFT2g>; Wed, 6 Mar 2002 14:28:36 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: "Scott L. Burson" <gyro@zeta-soft.com>
Subject: Re: Performance issue on dual Athlon MP
Date: Wed, 6 Mar 2002 20:28:25 +0100
X-Mailer: KMail [version 1.3.9]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200203062028.25738.Dieter.Nuetzel@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 6. März 2002 18:47:02, Scott L. Burson wrote:
> I have a dual Athlon MP box (Tyan S2460 Tiger MP, 1.53 GHz, 2.5 GB Corsair
> PC2100).  The initial installation was of SuSE 7.3, but I have upgraded to
> 2.4.17 with Andrea's 3.5 GB userspace patch.

Try 2.4.19-pre2-ac2 or 2.4.19pre1aa1+O(1). Maybe preemption can help, too.

Regards,
	Dieter
