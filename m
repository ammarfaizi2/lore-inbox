Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262170AbTCRGPU>; Tue, 18 Mar 2003 01:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262172AbTCRGPU>; Tue, 18 Mar 2003 01:15:20 -0500
Received: from curry.ceng.metu.edu.tr ([144.122.171.200]:27288 "EHLO
	curry.ceng.metu.edu.tr") by vger.kernel.org with ESMTP
	id <S262170AbTCRGPT>; Tue, 18 Mar 2003 01:15:19 -0500
Message-ID: <3E76BCA9.3060902@ceng.metu.edu.tr>
Date: Tue, 18 Mar 2003 08:28:57 +0200
From: Mehmet Ersan TOPALOGLU <mersan@ceng.metu.edu.tr>
Reply-To: mersan@ceng.metu.edu.tr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: process resident in memory
Content-Type: text/plain; charset=ISO-8859-9; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am a newbie in kernel programming.
And am sorry if something related previously asked.
I wonder if it is possible to following situation is possible or not.

let say i have a user process p1.
p1 does some malloc, and file i/o etc
i initiate it during boot time.
it stays resident in memory as if kernel it self (??)
and its priority is very very high

-- 
- mersan
     mersan@ceng.metu.edu.tr
     mersan@metu.edu.tr

	LIFE WORTH LIVING WITHOUT YOU?

