Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265409AbSKSOSR>; Tue, 19 Nov 2002 09:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265475AbSKSOSQ>; Tue, 19 Nov 2002 09:18:16 -0500
Received: from inet-mail2.oracle.com ([148.87.2.202]:21698 "EHLO
	inet-mail2.oracle.com") by vger.kernel.org with ESMTP
	id <S265409AbSKSOSJ>; Tue, 19 Nov 2002 09:18:09 -0500
Message-ID: <3DDA4921.30403@oracle.com>
Date: Tue, 19 Nov 2002 15:22:25 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Consulting Premium Services
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: Oracle 9.2 OOMs again at startup in 2.5.4[78]
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

...just like it did a few kernels ago (the current->mm issue in 2.5.19
  that eventually got fixed in 2.5.30 or thereabouts, introduced for the
  bk-enabled by cset 1.373.221.1).

I'll go building a 2.5.44 kernel (think it's the only one I didn't have
  too much trouble building / booting in the 2.5.4x series before .47)
  and see whether it works or not.


Later,

--alessandro

  "Seems that you can't get any more than half free"
        (Bruce Springsteen, "Straight Time")

