Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312833AbSDBJVn>; Tue, 2 Apr 2002 04:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312834AbSDBJVd>; Tue, 2 Apr 2002 04:21:33 -0500
Received: from pro18.it.dtu.dk ([130.225.76.218]:47301 "EHLO pro18.it.dtu.dk")
	by vger.kernel.org with ESMTP id <S312833AbSDBJVV>;
	Tue, 2 Apr 2002 04:21:21 -0500
Message-ID: <3CA9780B.7040900@fugmann.dhs.org>
Date: Tue, 02 Apr 2002 11:21:15 +0200
From: Anders Fugmann <afu@fugmann.dhs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020401 Debian/2:0.9.9-3pre4v5
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Process info
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Is it possible to obtain per process statistics in linux 2.4/2.5?
e.g. #ticks the process is assigned to a PE (Processing element), #ticks 
  suspended (blocked) state, #ticks on runqueue? etc.

The reason for me asking is that I want to simulate some load-cases on 
Linux, and therefore need some real data on how process on behaves.
(How much CPU-time does it want/need, How often does the process suspend 
itself and for how long, etc.)

Anyone out there who as information on this. I was hoping to simulate a 
gcc process. Then add 200 of them, and see how my small simulator 
behaves, and compare this to how things are actually working in Linux.
(the old `make bzImage -j 200` test.)

Regards
Anders Fugmann









