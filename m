Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274724AbRIUAzO>; Thu, 20 Sep 2001 20:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274725AbRIUAzE>; Thu, 20 Sep 2001 20:55:04 -0400
Received: from mx3.port.ru ([194.67.57.13]:1803 "EHLO smtp3.port.ru")
	by vger.kernel.org with ESMTP id <S274724AbRIUAzA>;
	Thu, 20 Sep 2001 20:55:00 -0400
From: Samium Gromoff <_deepfire@mail.ru>
Message-Id: <200109210517.f8L5Hje00537@vegae.deep.net>
Subject: 2.4.9-ac12 weird mc hang
To: linux-kernel@vger.kernel.org
Date: Fri, 21 Sep 2001 05:17:45 +0000 (Local time zone must be set--see zic manual page)
Cc: alan@lxorguk.ukuu.org.uk
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        Hello folks ac12-preempt popped with a new issue:
    strange it is or not, but i cant start mc since it hangs
  in random places (as strace shows).
  	Except my thought that its preempt-unrelated there isnt
  much to add. Btw console losing issues are back... grr... :(
        Even glibc/mc recompilation seems not to help...

cheers, Samium Gromoff

