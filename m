Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267647AbTGTSUV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 14:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267678AbTGTSUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 14:20:21 -0400
Received: from mail.uptime.at ([62.116.87.11]:11656 "EHLO mail.uptime.at")
	by vger.kernel.org with ESMTP id S267647AbTGTSUT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 14:20:19 -0400
From: "Oliver Pitzeier" <o.pitzeier@uptime.at>
To: <WHarms@bfs.de>, <linux-kernel@vger.kernel.org>
Subject: RE: problem linux-2.6.0-test1 on alpha
Date: Sun, 20 Jul 2003 20:33:56 +0200
Organization: UPtime system solutions
Message-ID: <000401c34eed$7b240640$1311a8c0@pitzeier.priv.at>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
In-Reply-To: 
Importance: Normal
X-MailScanner-Information: Please contact UPtime Systemloesungen for more information
X-MailScanner: clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-5.8, required 4.1,
	BAYES_01 -5.40, QUOTED_EMAIL_TEXT -0.38)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Walter!

>  i have a problem with GNU linker for alpha. it crashes when 
> linking. ( I compiled with gcc 2.96.)
>  
>   LD      .tmp_vmlinux1
> make: *** [.tmp_vmlinux1] Fehler 139
> 
> I have tried 2.12,2.13,2.14 sofar, no success at all. did 
> anyone else tried 2.6 on alpha ?

I have 2.6.0-test1 running on my AS 1000A/333:

[oliver@track oliver]$ rpm -q modutils kernel gcc binutils
modutils-2.4.21-18
kernel-2.6.0test1-6
gcc-3.1-6
binutils-2.12.90.0.7-3

Please note, that I have build the kernel rpm myself by using 'make rpm' and
YES, I did configure it before using 'make menuconfig'. :)

Best regards,
 Oliver

