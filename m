Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315481AbSFAPx1>; Sat, 1 Jun 2002 11:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315627AbSFAPx0>; Sat, 1 Jun 2002 11:53:26 -0400
Received: from avplin2.lanet.lv ([195.13.129.96]:16058 "EHLO avplin2.lanet.lv")
	by vger.kernel.org with ESMTP id <S315481AbSFAPxZ>;
	Sat, 1 Jun 2002 11:53:25 -0400
Message-ID: <3CF8EDEF.3070708@lanet.lv>
Date: Sat, 01 Jun 2002 18:53:19 +0300
From: Andris Pavenis <pavenis@lanet.lv>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: haiquy@yahoo.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-pre9-ac3 still OOPS when exiting X with i810 chipset
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > I hope the problem has been fixed but not, Exactly the
 > same oop message as I posted before; from 2.4.19-pre7
 > up ; it always happen.

Same hardware as I'm using, but I haven't seen any OOPSes
already for a long time.

Currently I'm using the same kernel 2.4.19-pre9-ac3, XFree86-4.2.0
(with one i810 chipset related fix applied), KDE-3.0.1
All these are compiled with gcc-3.1 release. I haven't seen
any kernel OOPS'es already for a rather long time.

Andris

PS. i810 fix I mentioned dos not fix kernel OOPS, but only
X11 fatal error when switching from X11 to console (especially nasty
with new KDE versions, haven't seen with GNOME)

Andris



