Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276686AbRJQNhT>; Wed, 17 Oct 2001 09:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276682AbRJQNhB>; Wed, 17 Oct 2001 09:37:01 -0400
Received: from babel.apana.org.au ([202.12.88.4]:46596 "EHLO
	babel.apana.org.au") by vger.kernel.org with ESMTP
	id <S276642AbRJQNgr>; Wed, 17 Oct 2001 09:36:47 -0400
Date: Wed, 17 Oct 2001 23:40:39 +1000
From: John August <johna@babel.apana.org.au>
To: linux-kernel@vger.kernel.org
Subject: keyboard / shutdown problem on 2.4.10
Message-ID: <20011017234039.D5068@babel.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am using kernel 2.4.10 and am not aware of these issues being fixed
for 2.4.12, based on jitterbug.  I'll upgrade to a 2.4.12 plus patches
if there's a good chance of them being fixed.

I am using a 1.2 GHZ Athlon with a K7VZA mainboard. 

When I issue a shutdown command, the computer halts but does not turn
itself off. This functionality was present on a 2.4.2-2 kernel, where
the computer turned itself off.

When I press the alt key in order to type in three digits to get keyboard
codes above 128, this does not work. I also have problems in remapping
the keyboard to get these high codes, but this could be operator error.

This functionality was present on a 2.2.17 kernel. The keyboard was 
munged by consolechars, but at least it started out working (again, this
could be operator error).

I'm not on the list, please forward any replies.

Thanks,

-- 
John August

There are no bad blocks.
There are only bad users.
