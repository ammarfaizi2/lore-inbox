Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271534AbRHPI75>; Thu, 16 Aug 2001 04:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271532AbRHPI7r>; Thu, 16 Aug 2001 04:59:47 -0400
Received: from mx6.port.ru ([194.67.57.16]:48140 "EHLO mx6.port.ru")
	by vger.kernel.org with ESMTP id <S271531AbRHPI7k>;
	Thu, 16 Aug 2001 04:59:40 -0400
From: "Samium Gromoff" <_deepfire@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: Apps losing control tty...
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [195.34.27.196]
Reply-To: "Samium Gromoff" <_deepfire@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E15XJ0J-000JGh-00@f11.mail.ru>
Date: Thu, 16 Aug 2001 12:59:51 +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

prerequisities: 2.4.7-vanille
     Recently (i cant recall when), i realised, that
some _different_ applications (like mikmod or something)
 are losing tty. I start these apps like that:
mikmod <random stuff skipped> > /dev/ttyXX 2>/dev/ttyXX < /dev/ttyXX &
and after some period of time, they loses the
tty, but this is not a 100% probability.

 I think it is relevant only for 2.4.7 in my situation...

thanks in advance...

---


cheers,


   Samium Gromoff
