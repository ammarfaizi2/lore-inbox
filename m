Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319346AbSHQFSc>; Sat, 17 Aug 2002 01:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319350AbSHQFSc>; Sat, 17 Aug 2002 01:18:32 -0400
Received: from floyd.blarg.net ([206.124.128.8]:55963 "EHLO mail.blarg.net")
	by vger.kernel.org with ESMTP id <S319346AbSHQFSb> convert rfc822-to-8bit;
	Sat, 17 Aug 2002 01:18:31 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Ian Eure <ieure@debian.org>
To: linux-kernel@vger.kernel.org
Subject: Bad time sync with 2.4.19 on a Dell Inspiron
Date: Fri, 16 Aug 2002 22:22:24 -0700
User-Agent: KMail/1.4.2
Organization: Debian
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200208162222.24959.ieure@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've recently noticed that the time on my newish Dell Inspiron 8100 drifts 
about 30 minutes behind real time in 24 hours.

It's got an Intel Mobile P3 1.13ghz CPU with SpeedStep, and I thought that 
might be the case, but I've got it set to run full-speed when plugged in, and 
it's been plugged in the whole time.

I'm seeing this with 2.4.18 & 2.4.19. Can anyone verify this? I've poked 
around with Google, and haven't seen any other complaints.

Please make sure I get CC'd on replies, since I'm not on the list.

-- 
Komm auf meine Sonnenbarke!
