Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269312AbRHQOcw>; Fri, 17 Aug 2001 10:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269237AbRHQOcm>; Fri, 17 Aug 2001 10:32:42 -0400
Received: from [211.47.66.50] ([211.47.66.50]:42411 "EHLO www10.tt.co.kr")
	by vger.kernel.org with ESMTP id <S269312AbRHQOcg>;
	Fri, 17 Aug 2001 10:32:36 -0400
Message-ID: <000e01c1272a$047b8c80$2e402fd3@tt.co.kr>
From: "=?ks_c_5601-1987?B?v8C0w7D6s7vAzyDIq7yuufw=?=" <antihong@tt.co.kr>
To: <linux-kernel@vger.kernel.org>
Subject: Kernel panic problem in 2.4.7
Date: Fri, 17 Aug 2001 23:36:35 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2462.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by leeloo.zip.com.au id AAA25523

Hello.. All

I have operated Redhat 6.2 based system(kernel 2.4.7)  which is Dual CPU and 512M Ram.

A few days ago, this system is down and the messages like below.

Jul 22 14:57:45 www kernel: Kernel panic: CPU context corrupt
Jul 25 19:25:30 www kernel: Kernel panic: CPU context corrupt
Jul 27 23:43:22 www kernel: Kernel panic: CPU context corrupt

this mailling list say that this is CPU Problem(overclocking....but it isn't).
So I changed other CPUs that I think  no problem.

But a few days later. kernel panic occured again.
(The system is 2.4.7)
the messages was 

Kernel panic:Aiee, killing interrupt handler
In interrupt handler - not syncing

This message is occured when the system's load average is a bit high.
(When I Kernel compile or packing with tar.. somthing like that..)

I searched all lists, But I couldn't find the "reason" and "answer".
I would like to know the reason and answer.

Please give me some advice about these problems.

 
 Thanks for your help.
  
 
ı:.Ë›±Êâmçë¢kaŠÉb²ßìzwm…ébïîË›±Êâmébìÿ‘êçz_âØ^n‡r¡ö¦zËëh™¨è­Ú&£ûàz¿äz¹Ş—ú+€Ê+zf£¢·hšˆ§~†­†Ûiÿÿïêÿ‘êçz_è®æj:+v‰¨ş)ß£ømšSåy«­æ¶…­†ÛiÿÿğÃí»è®å’i
