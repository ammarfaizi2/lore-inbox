Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129279AbRBRXIm>; Sun, 18 Feb 2001 18:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129339AbRBRXId>; Sun, 18 Feb 2001 18:08:33 -0500
Received: from f91.law7.hotmail.com ([216.33.237.91]:62221 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S129279AbRBRXIR>;
	Sun, 18 Feb 2001 18:08:17 -0500
X-Originating-IP: [193.237.25.148]
From: "lafanga lafanga" <lafanga1@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Proliant hangs with 2.4 but works with 2.2.
Date: Sun, 18 Feb 2001 23:08:11 -0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F91i3lDraH8kvLMxLQn00012fe9@hotmail.com>
X-OriginalArrivalTime: 18 Feb 2001 23:08:11.0857 (UTC) FILETIME=[AA428410:01C099FF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Compaq Proliant 1600 server which can be hung on demand with all 
the 2.4 series kernels I have tried (2.4, 2.4.1 & 2.4.2-pre3). Kernel 2.2.16 
runs perfectly (from a default RH7.0).

I have ensured that the server meets the necessary requirements for the 2.4 
kernels (modutils etc) and I have tried kgcc and various gcc versions. When 
compiling I have tried default configs and also minimalist configs (with 
only cpqarray and tlan). I have also ensured that I have the latest current 
SmartStart CD (4.9) and have setup the firmware for installing Linux.

The programs 'gpm', 'kudzu' and 'startx' all hang the server immediately 
after they exit (with exit status 0). I cannot pinpoint why the kernel hangs 
and would appreciate any help. The only thing I suspect it may be is that it 
is a dual processor mobo with only one processor but I don't know how this 
detection has changed in the 2.4 kernels.

Thanks.

Ayub.
_________________________________________________________________________
Get Your Private, Free E-mail from MSN Hotmail at http://www.hotmail.com.

