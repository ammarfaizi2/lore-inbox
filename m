Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136036AbRDVLMN>; Sun, 22 Apr 2001 07:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136037AbRDVLLy>; Sun, 22 Apr 2001 07:11:54 -0400
Received: from mx1.port.ru ([194.67.23.32]:35593 "EHLO mx1.port.ru")
	by vger.kernel.org with ESMTP id <S136036AbRDVLLj>;
	Sun, 22 Apr 2001 07:11:39 -0400
From: "Samium Gromoff" <_deepfire@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: Re: Delivery 2.4.x serial corruption
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [195.34.30.62]
In-Reply-To: <20010422110551Z136036-683+2202@vger.kernel.org>
Reply-To: "Samium Gromoff" <_deepfire@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E14rHmD-0002NB-00@f3.mail.ru>
Date: Sun, 22 Apr 2001 15:11:37 +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   H guys, recently i have narrowed down the problem
 with my modem what had pissed me off for a long time:_
 before i thought it was ppp problem, because my small_
 brain maked that simple logic chain: if ppp0 iface err
 count grows -> tis is ppp problems.___________________
  The fact is what the actual problem touches only
 serial port in 2,4, not 2.2.__
 it looks like that:  each time i enter minicom_______
 and request some info from my modem (ati6 or someth)__
 an fixed amount is going excellent, but then things___
 goes worse: second ati6 answer is HEAVILY corrupted___
 alot of chars is gone, some had come..._______________
    in msdos such a problem does NOT exist______ additional info: it sligtly depends on LDEV sample time
   
   i use an `95 year 486 mboard with am5x86
  p.s. with internal modems this problem is not that
  chilling
                     thanx guys
 
