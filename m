Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313123AbSDOJTm>; Mon, 15 Apr 2002 05:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313124AbSDOJTl>; Mon, 15 Apr 2002 05:19:41 -0400
Received: from smtp3.cern.ch ([137.138.131.164]:1431 "EHLO smtp3.cern.ch")
	by vger.kernel.org with ESMTP id <S313123AbSDOJTl>;
	Mon, 15 Apr 2002 05:19:41 -0400
Message-ID: <3CBA9B27.1020904@cern.ch>
Date: Mon, 15 Apr 2002 11:19:35 +0200
From: Enrico BRAVIN <Enrico.bravin@cern.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Direct access to IDE disk from kernel modules
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Is there a way to directly dump a buffer on an IDE disk from inside a 
kernel module without goig trough user space?
I have written a driver for a frame grabber and would like be able to 
dump the frames real time directly to a dedicated IDE disk.
My frames are already in a DMAble buffer.

Please cc my directly

