Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271956AbRHVT6R>; Wed, 22 Aug 2001 15:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272097AbRHVT6J>; Wed, 22 Aug 2001 15:58:09 -0400
Received: from web10902.mail.yahoo.com ([216.136.131.38]:8204 "HELO
	web10902.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S271956AbRHVT5y>; Wed, 22 Aug 2001 15:57:54 -0400
Message-ID: <20010822195810.75425.qmail@web10902.mail.yahoo.com>
Date: Wed, 22 Aug 2001 12:58:10 -0700 (PDT)
From: Brad Chapman <kakadu_croc@yahoo.com>
Subject: 2.4.9 VM/VMA subsystem works much better
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Everyone,

	Just a note: the VMA sanity patch which went in to 2.4.9
has improved Mozilla's performance considerably. I did a rough
calculation based on startup time and found that Mozilla started
approximately 10%-12% faster on 2.4.9 then 2.4.8. Plus, I've
found that swapping is actually starting to work again, although
it still tends to stick at certain times.

	Great job everyone.

Brad

=====
Brad Chapman

Permanent e-mail: kakadu_croc@yahoo.com
Current e-mail: kakadu@adelphia.net
Alternate e-mail: kakadu@netscape.net

__________________________________________________
Do You Yahoo!?
Make international calls for as low as $.04/minute with Yahoo! Messenger
http://phonecard.yahoo.com/
