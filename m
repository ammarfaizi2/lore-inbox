Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318141AbSIAWVr>; Sun, 1 Sep 2002 18:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318143AbSIAWVr>; Sun, 1 Sep 2002 18:21:47 -0400
Received: from f218.law15.hotmail.com ([64.4.23.218]:36615 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S318141AbSIAWVq>;
	Sun, 1 Sep 2002 18:21:46 -0400
X-Originating-IP: [195.92.67.74]
From: "dirty boy" <slashdotcommacolon@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Linux ELF Implementation
Date: Sun, 01 Sep 2002 22:26:10 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F218kOUkl2SN8anK0B30000890f@hotmail.com>
X-OriginalArrivalTime: 01 Sep 2002 22:26:10.0681 (UTC) FILETIME=[92D99690:01C25206]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hey people :)

i would be greatful if one of you knowledgeable people could settle a bet 
for me...

im learning about the ELF specification with a friend of mine, were hoping 
to get a better understanding of how these things work, and a wild idea 
occurred to us - would it be possible to create a valid ELF executable from 
purely printable ASCII characters ?

by that i mean, you would be able to literally cat > a.out and enter your 
executable from the keyboard! it wouldnt have todo anything, just return 
0...

the file wouldnt have to be portable, only the fields that the kernel is 
going to notice would have to be present, so long as it executes!

im convinced the answer is no - but my friend says it is, he says hes seen 
it done in PE format ( although we cant find it on the web ) and therefore 
theres no reason why it couldnt be done in ELF.

Thanks  so much!!

[ please cc me if possible, im not a subscriber and will save me waiting for 
the responses to show up on google! ]

_________________________________________________________________
Send and receive Hotmail on your mobile device: http://mobile.msn.com

