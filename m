Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129436AbQLOPmo>; Fri, 15 Dec 2000 10:42:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129697AbQLOPme>; Fri, 15 Dec 2000 10:42:34 -0500
Received: from ms1.hinet.net ([168.95.4.10]:27070 "EHLO ms1.hinet.net")
	by vger.kernel.org with ESMTP id <S129436AbQLOPmR>;
	Fri, 15 Dec 2000 10:42:17 -0500
Message-ID: <3A3A3472.33349B51@teatime.com.tw>
Date: Fri, 15 Dec 2000 23:10:42 +0800
From: Tommy Wu <tommy@teatime.com.tw>
Reply-To: tommy@teatime.com.tw
Organization: TeaTime Development
X-Mailer: Mozilla 4.76 [zh] (Windows NT 5.0; U)
X-Accept-Language: en,zh,zh-TW,zh-CN
MIME-Version: 1.0
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: bug: kernel timer added twice ad 000000000110052c.
In-Reply-To: <3A3A0D9A.426A2FB0@teatime.com.tw> <20001215163747.F829@nightmaster.csn.tu-chemnitz.de>
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser ¼g¹D:
> 
> >   I got the message as subject when I load the ip_conntrack/iptable_nat modules
> >   for kernel 2.4.0-test9 to test12. All have the same problem.
> Don't do that.
> Recompile the modules _ALWAYS_ along with the kernel you compile
> and use.

  Yes, I do that everytime, but it still have such message when I load iptables modules.
  I also try to compile them all into the kernel, they are still got same message. :-(

-- 

    Tommy Wu
    mailto:tommy@teatime.com.tw
    http://www.teatime.com.tw/~tommy
    ICQ: 22766091
    Mobile Phone: +886 936 909490
    TeaTime BBS +886 2 3151964 24Hrs V.Everything

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
