Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129134AbRCEJul>; Mon, 5 Mar 2001 04:50:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129136AbRCEJuc>; Mon, 5 Mar 2001 04:50:32 -0500
Received: from zeus.kernel.org ([209.10.41.242]:10185 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129134AbRCEJuT>;
	Mon, 5 Mar 2001 04:50:19 -0500
Message-ID: <711690E0140AD4118D7000508B5D525B1FEE0C@ukmsx2.emea.att.com>
From: "Quatrini, Lorenzo " <lquatrini@emea.att.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: REPOST: Looking for MP-BIOS-less patch
Date: Mon, 5 Mar 2001 09:49:07 -0000 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have found an old NCR 3430 system (with MCA, and proprietary MP board)
As of now, I was able to install and recompile linux on it (2.2.14-5.0 and
2.2.18), but I haven't found any way to get smp running.
As far as I know the NCR is not Intel MP compliant.

Looking on the ml archive I found a post from Ingo Molnar for a
"MP-BIOS-less" patch, but I could'nt find it.

So I asking if I can find a patch or there is some boot-parameter for the
kernel 2.2.14 or 2.2.18 or even 2.4.0 for forcing linux to go in MP mode
without an MP compliant Bios.

Thanks in advance
Best regards

Lorenzo Quatrini


P.S. I'm new to this ml, and I'm not a kernel developer,but I'm just
searching for help, so let me know if I should'nt post here.
Before posting here I deeply searched for help in the FAQ and
other sources, but I could'n find anything, so I decided to ask for your
help.

P.P.S. I'm reposting because I had problems with mails and I had to change
subscription
