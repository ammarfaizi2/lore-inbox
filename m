Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129583AbRCGLqI>; Wed, 7 Mar 2001 06:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129609AbRCGLp5>; Wed, 7 Mar 2001 06:45:57 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:52754 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S129583AbRCGLpu>; Wed, 7 Mar 2001 06:45:50 -0500
Message-ID: <3AA6200E.8C398B2E@folkwang-hochschule.de>
Date: Wed, 07 Mar 2001 12:48:30 +0100
From: Jörn Nettingsmeier 
	<nettings@folkwang-hochschule.de>
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: gibbs@scsiguy.com
CC: linux-kernel@vger.kernel.org
Subject: yacc dependency of aic7xxx driver
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello justin !

i have just tried to install the latest 2.4.3pre3 kernel with your
driver.
it failed with yacc: file not found.
while i could install yacc, i have never had to use it before. i was
assuming that the newer bison could do the same thing (which is what
i have installed).
so far, the kernel has not relied on yacc, which is why i'd like to
ask you if it's possible to make it work with bison.

sorry if this has been dealt with before, but i didn't find anything
in the lkml archive.

regards,

jörn

please keep me cc:ed, i'm not on lkml. thanks.

-- 
Jörn Nettingsmeier     
home://Kurfürstenstr.49.45138.Essen.Germany      
phone://+49.201.491621
http://www.folkwang-hochschule.de/~nettings/
