Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271277AbRHQLFd>; Fri, 17 Aug 2001 07:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271339AbRHQLFZ>; Fri, 17 Aug 2001 07:05:25 -0400
Received: from mx5.port.ru ([194.67.57.15]:57094 "EHLO mx5.port.ru")
	by vger.kernel.org with ESMTP id <S271277AbRHQLFO>;
	Fri, 17 Aug 2001 07:05:14 -0400
From: "Samium Gromoff" <_deepfire@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: Re: Apps losing control tty...
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [195.34.30.69]
Reply-To: "Samium Gromoff" <_deepfire@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E15XhQd-0003X4-00@f10.mail.ru>
Date: Fri, 17 Aug 2001 15:04:39 +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

     Ok, need to make my point clear:

  time X: App receives keypresses, and shows its progresses (various numbers updating, etc...)

  time X+1: Keypresses are not fed to application,
but are displayed on the vconsole, application doesnt
update the screen, but is perfectly functional in all
other aspects...

sorry for inconvenience...

---


cheers,


   Samium Gromoff
