Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270117AbRHMLzx>; Mon, 13 Aug 2001 07:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270118AbRHMLzm>; Mon, 13 Aug 2001 07:55:42 -0400
Received: from mx5.port.ru ([194.67.57.15]:6411 "EHLO mx5.port.ru")
	by vger.kernel.org with ESMTP id <S270117AbRHMLz2>;
	Mon, 13 Aug 2001 07:55:28 -0400
From: "Samium Gromoff" <_deepfire@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: Re: strange gcc crashes...
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: 10.0.0.1 via proxy [195.34.30.65]
Reply-To: "Samium Gromoff" <_deepfire@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E15WGJY-000Ecx-00@f12.port.ru>
Date: Mon, 13 Aug 2001 15:55:24 +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

at Aug 11, 01 06:51:15 PM +0000 Mark Hahn wrote:
>>     so it seems to me like kernel problem...
>
>why is that?  I've never seen a sig11 from production >code
>that wasn't caused by flakey ram.  in fact, your >descriptions
>are a perfect example of similar hardware problems.

and some other people told me about cpu overheating...

but 55 minutes long memtest run showed no problems et al
 with cpu (P166-nonMMX-oc`ed to 180) staying warm, not by any means hot
 on mobo Zida 5DVX.

 maybe 55 min is not enough for proper mem testing?

---


cheers,


   Samium Gromoff
