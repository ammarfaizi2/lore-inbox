Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132988AbRDRDRq>; Tue, 17 Apr 2001 23:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132989AbRDRDR1>; Tue, 17 Apr 2001 23:17:27 -0400
Received: from [24.93.67.54] ([24.93.67.54]:11027 "EHLO mail7.triad.rr.com")
	by vger.kernel.org with ESMTP id <S132988AbRDRDRX>;
	Tue, 17 Apr 2001 23:17:23 -0400
Message-ID: <3ADD07D7.80806@triad.rr.com>
Date: Tue, 17 Apr 2001 23:19:51 -0400
From: Ghadi Shayban <ghad@triad.rr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.3-ac9 i686; en-US; rv:0.8.1+) Gecko/20010417
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: rw-semaphore regression in 2.4.4-pre4
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Processes, most easily mozilla, get stuck in the "D" state in 
2.4.4-pre4.  I don't believe this was fixed in pre2 but now it happens 
again.      Also, just a minor error, but 2.4.4-pre4 modules are put in 
the 2.4.3 directory.  The version number was probably accidentally left 
the same.

Cheers,
Ghadi Shayban


Pianist at the NC School of the Arts

