Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280736AbRKBRNI>; Fri, 2 Nov 2001 12:13:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280737AbRKBRM6>; Fri, 2 Nov 2001 12:12:58 -0500
Received: from [207.139.192.60] ([207.139.192.60]:3547 "HELO tpm.e-mfg.net")
	by vger.kernel.org with SMTP id <S280736AbRKBRMu>;
	Fri, 2 Nov 2001 12:12:50 -0500
Message-ID: <3BE2D2DB.5010202@e-mfg.net>
Date: Fri, 02 Nov 2001 12:07:39 -0500
From: "Erik W. Beese" <erikb@e-mfg.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2-2 i686; en-US; 0.7) Gecko/20010316
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: USB OHCI bug under 2.4.12
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting a kernel panic in the 2.4.12 kernel caused by the usb-ohci 
kernel module

I'm getting the message:

kernel BUG at usb-ohci.h:464!
invalid opened at: 0000
CPU: 0

etc etc.

Has this been addressed in any newer kernels? I've seen a lot of UHCI 
fixes and other USB support changed but nothing specific for OHCI

TIA,
Erik Beese

