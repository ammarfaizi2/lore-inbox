Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281048AbRKOUmi>; Thu, 15 Nov 2001 15:42:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281047AbRKOUm3>; Thu, 15 Nov 2001 15:42:29 -0500
Received: from [199.29.68.123] ([199.29.68.123]:12809 "EHLO MailAndNews.com")
	by vger.kernel.org with ESMTP id <S281050AbRKOUmR>;
	Thu, 15 Nov 2001 15:42:17 -0500
X-WM-Posted-At: MailAndNews.com; Thu, 15 Nov 01 15:41:34 -0500
X-WebMail-UserID: jweeks
Date: Thu, 15 Nov 2001 15:41:34 -0500
From: Jeff Weeks <jweeks@MailAndNews.com>
To: linux-kernel@vger.kernel.org
X-EXP32-SerialNo: 50000000
Subject: AMD 761 support in Linux
Message-ID: <3BF4EEE3@MailAndNews.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Mailer: InterChange (Hydra) SMTP v3.62
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,
 
Sorry to bother you, but I noticed a message of yours on the internet which 
said, to enable AMD 761 support in Linux you should set 
"agp_try_unsupported=3D1" option... but where?
 
There's no option for that in the kernel config, so I'm assuming it's in a 
header file somewhere, or something.  I've got AGP support compiled directly 
in the kernel, so I can't specify it as a module parameter... and I'd like to 
keep it right in the kernel if possible.
 
Any help would be _greatly_ appreciated :)
 
Thanks,
Jeff
jweeks@mailandnews.com

