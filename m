Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271142AbRHTJua>; Mon, 20 Aug 2001 05:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271147AbRHTJuT>; Mon, 20 Aug 2001 05:50:19 -0400
Received: from mx5.port.ru ([194.67.57.15]:56850 "EHLO mx5.port.ru")
	by vger.kernel.org with ESMTP id <S271142AbRHTJuH>;
	Mon, 20 Aug 2001 05:50:07 -0400
From: "Samium Gromoff" <_deepfire@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: 2.4.8/2.4.8-ac7 sound crashes
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [195.34.27.176]
Reply-To: "Samium Gromoff" <_deepfire@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E15YlfQ-000EZS-00@f5.mail.ru>
Date: Mon, 20 Aug 2001 13:48:20 +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        I do not know if this problem is reported already,
    since i read lkml thru web-archive, with accompanying
update delays.

    2.4.8 dies after ~1/2 minute of mpg123 playback,
    with tty switching freeze, and typing out 
    continuously (i`d say infinitely) call trace.

        ac7 acts this way too, but before death
    sound stalls *some* times, i then each time restart
    the proggie which emits it. This pattern survives
    4-5 stalls, after which - final trace dump.

    gcc-2.95.3, sb16 - genuine, vanilla ac7, vanilla 
    2.4.8.

    further information upon request.

---


cheers,


   Samium Gromoff
