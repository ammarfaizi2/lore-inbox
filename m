Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312127AbSCTJsk>; Wed, 20 Mar 2002 04:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312121AbSCTJsa>; Wed, 20 Mar 2002 04:48:30 -0500
Received: from [159.226.4.246] ([159.226.4.246]:19985 "EHLO intec.iscas.ac.cn")
	by vger.kernel.org with ESMTP id <S312120AbSCTJsP>;
	Wed, 20 Mar 2002 04:48:15 -0500
Message-ID: <000701c1cff4$5beb6d50$17c0c0c0@shu>
From: "Guoqiang Shu" <guoqiang@itechs.iscas.ac.cn>
To: <linux-kernel@vger.kernel.org>
Subject: static buffer in module
Date: Wed, 20 Mar 2002 17:47:55 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6700
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mangalore.zipworld.com.au id AAA13536

hello,

     when I declare a buffer statically in a module ( char buf[1024]), and 
 later use __pa(buf) and virt_to_phys(buf),I get an address beyond the physical 
 memory bound. how to get the real physical address of such buffers if I wanna 
 mmap them to user space? 
     thank you very much .

   any instructions pls. fwd to my address.

 George .Shu
 
ı:.Ë›±Êâmçë¢kaŠÉb²ßìzwm…ébïîË›±Êâmébìÿ‘êçz_âØ^n‡r¡ö¦zËëh™¨è­Ú&£ûàz¿äz¹Ş—ú+€Ê+zf£¢·hšˆ§~†­†Ûiÿÿïêÿ‘êçz_è®æj:+v‰¨ş)ß£ømšSåy«­æ¶…­†ÛiÿÿğÃí»è®å’i
