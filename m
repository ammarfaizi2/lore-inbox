Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289958AbSAPOvH>; Wed, 16 Jan 2002 09:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289959AbSAPOu5>; Wed, 16 Jan 2002 09:50:57 -0500
Received: from ztxmail04.ztx.compaq.com ([161.114.1.208]:5638 "EHLO
	ztxmail04.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S289958AbSAPOus>; Wed, 16 Jan 2002 09:50:48 -0500
Message-ID: <3C459334.7070408@zk3.dec.com>
Date: Wed, 16 Jan 2002 09:50:28 -0500
From: Peter Rival <frival@zk3.dec.com>
Organization: Tru64 QMG Performance Engineering
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Anyone tried 2.5.[23] on Alpha?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just wanted to check if anyone has tried 2.5.[23] on Alpha yet.  It 
appears Ingo's scheduler changes haven't been ported to work on the 
Alpha platform as yet.  I went through the pain yesterday of updating 
most of the 2.5.2 code and it now compiles, but the system crashes right 
at the beginning of init_idle(). I can send the patches I have so far, 
but seeing as it doesn't even come close to booting, I'm not sure I got 
this much right. ;)  Anyone?

  - Pete

