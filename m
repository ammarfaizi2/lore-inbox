Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269515AbRHYWUy>; Sat, 25 Aug 2001 18:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269543AbRHYWUo>; Sat, 25 Aug 2001 18:20:44 -0400
Received: from mx3.port.ru ([194.67.57.13]:60686 "EHLO mx3.port.ru")
	by vger.kernel.org with ESMTP id <S269515AbRHYWU2>;
	Sat, 25 Aug 2001 18:20:28 -0400
From: "Samium Gromoff" <_deepfire@mail.ru>
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: unrelated 2.4.x (x=0-9) sound
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [195.34.27.212]
Date: Sat, 25 Aug 2001 22:20:43 +0000 (GMT)
Reply-To: "Samium Gromoff" <_deepfire@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E15alnH-000AZt-00@f8.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2.      Chipsets that don't give the ISA bus any useful share of bandwidth
>         during AGP or PCI traffic
    i.e. you mean that PCI-ISA bridge doesnt provide enough
  realtimeness to fill internal sb buffer?

     yes it sounds like that, because i can hardly
  realize their existence at 11025... (but i suppose
  if they were, i hardly would be able to hear them...)

     i have the next "but": isn`t internal sb buffer
  enough large to flatten these io peaks?

     even more: sound click even when i strike the key once, with 100% probability.

     ofcourse this is maybe because mc sends alot of data
  over the bus in the response to the keypress.
  
     it also explains why less clicks only after
  first-after-consoleswitch-keypress.

     but next why: why "find /" does not achieve
  same effect? the datastream is _way_ larger!

---


cheers,


   Samium Gromoff
