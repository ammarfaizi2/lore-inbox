Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133028AbRDRGTV>; Wed, 18 Apr 2001 02:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133029AbRDRGTM>; Wed, 18 Apr 2001 02:19:12 -0400
Received: from GEOV11.TelDa.Net ([193.96.236.53]:46713 "HELO TDN.TelDa.Net")
	by vger.kernel.org with SMTP id <S133028AbRDRGTD>;
	Wed, 18 Apr 2001 02:19:03 -0400
Message-ID: <3ADD241B.60C9928F@karstenkreher.de>
Date: Wed, 18 Apr 2001 07:20:27 +0200
From: Karsten Kreher <email@karstenkreher.de>
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.4.3 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: compiling buz.c problem in 2.4.3 (missing symbol)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

... can be resolved by adding the missing define in line 65

#define KMALLOC_MAXSIZE (512*1024)

regards,
Karsten Kreher

