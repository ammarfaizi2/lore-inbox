Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317916AbSGWCxh>; Mon, 22 Jul 2002 22:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317917AbSGWCxh>; Mon, 22 Jul 2002 22:53:37 -0400
Received: from ns1i.atr.co.jp ([210.146.67.2]:55242 "EHLO mailgw1.atr.co.jp")
	by vger.kernel.org with ESMTP id <S317916AbSGWCxg>;
	Mon, 22 Jul 2002 22:53:36 -0400
Message-ID: <3D3CC5C4.54E9EF72@atr.co.jp>
Date: Tue, 23 Jul 2002 11:56:04 +0900
From: "J. Hart" <jhart@atr.co.jp>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: jhart@atr.co.jp
Subject: Re: File Corruption in Kernel 2.4.18
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here is a further update on the file corruption question :

     I ran the DFT utility which picked up two bad sectors, which I then
repaired.  A rerun of DFT after that gave no further reports of any problems.  I
then tried the directory tree copy (cp -a aminet aminet1) which produced one
corrupted file at the destination.  All the other destination files in the tree
(70652 files, 7.6G) appeared to be correct.

     An additional rerun of the IBM DFT utility after this reported no problems
despite the corrupt copy.

     In order to resolve this issue, my employer is considering the replacement
of my current machine with a new one having the following specifications :


motherboard: Asus P4T AGP Pro/4X
ram        : 1Gb
OS         : Linux 2.4.7-10 i686 unknown
CPU        : Intel(R) Pentium(R) 4 CPU 1800MHz
Gfx        : Matrox Graphics, Inc. MGA G400 AGP
drives     : Seagate 40gb UATA ST340810A (two of these)
controller : Intel PIIX4 Ultra 100 Chipset
           : (Intel Corporation 82801BA IDE U100)
chipset    : Intel Corporation 82850 850 (Tehama) Chipset Host Bridge (MCH)

     Are there any outstanding issues with machines of this new configuration as
there seemed to be with my old machine ?

With Thanks,

     J. Hart
