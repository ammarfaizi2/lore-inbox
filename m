Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267227AbRGTTNH>; Fri, 20 Jul 2001 15:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267234AbRGTTM5>; Fri, 20 Jul 2001 15:12:57 -0400
Received: from smtp.monmouth.com ([209.191.58.6]:39697 "EHLO smtp.monmouth.com")
	by vger.kernel.org with ESMTP id <S267227AbRGTTMm>;
	Fri, 20 Jul 2001 15:12:42 -0400
Message-ID: <3B5874AC.43D2E698@monmouth.com>
Date: Fri, 20 Jul 2001 14:13:00 -0400
From: Dipak Biswas <dipak@monmouth.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-6.1smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Please suggest me
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi All,
    I'm quite new to linux world. I've a very awkard question for you.
That is: I'm writting an user process, where I need all outgoing
IP packets to be blocked and captured. First, is it really possible? If
yes, how? I don't want to make any kernel source code changes. A wild
guess: by configuration changes, is it possible to make IP process write
on to a particular FD which I can read when I require?

Thanks,
dipak

