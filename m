Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130346AbQLOM4K>; Fri, 15 Dec 2000 07:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129325AbQLOM4A>; Fri, 15 Dec 2000 07:56:00 -0500
Received: from c252.h203149202.is.net.tw ([203.149.202.252]:62341 "EHLO
	mail.tahsda.org.tw") by vger.kernel.org with ESMTP
	id <S130346AbQLOMzs>; Fri, 15 Dec 2000 07:55:48 -0500
Message-ID: <3A3A0D9A.426A2FB0@teatime.com.tw>
Date: Fri, 15 Dec 2000 20:24:58 +0800
From: Tommy Wu <tommy@teatime.com.tw>
Reply-To: tommy@teatime.com.tw
Organization: TeaTime Development
X-Mailer: Mozilla 4.76 [zh] (Windows NT 5.0; U)
X-Accept-Language: en,zh,zh-TW,zh-CN
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: bug: kernel timer added twice ad 000000000110052c.
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  I got the message as subject when I load the ip_conntrack/iptable_nat modules
  for kernel 2.4.0-test9 to test12. All have the same problem.

  I'm running on a UltraSparc machine. (Debian GNU/Linux 2.2 with kernel 2.4).

-- 

    Tommy Wu
    mailto:tommy@teatime.com.tw
    http://www.teatime.com.tw/~tommy
    ICQ: 22766091
    Mobile Phone: +886 936 909490
    TeaTime BBS +886 2 31515964 24Hrs V.Everything

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
