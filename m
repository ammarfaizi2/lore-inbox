Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131158AbRCUERU>; Tue, 20 Mar 2001 23:17:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131175AbRCUERL>; Tue, 20 Mar 2001 23:17:11 -0500
Received: from sy5kts4-p22.ust.hk ([143.89.224.172]:3588 "EHLO hingwah")
	by vger.kernel.org with ESMTP id <S131158AbRCUERB>;
	Tue, 20 Mar 2001 23:17:01 -0500
Date: Wed, 21 Mar 2001 12:16:05 +0800
To: linux-kernel@vger.kernel.org
Subject: Hang when using loop device
Message-ID: <20010321121605.A822@hingwah>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
From: hingwah@programmer.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

	Recently my ext2 partition out of space so I have made a regular file
in the FAT32 partition and format it  as ext2 partiton and mount it as 
loop device.However,occasionaly when I extract a large tar to the loop device..
The computer will hang while extracting. I wonder if deadlock occur.
I'm using kernel 2.4.1 now and there is no problem when I am using
kernel 2.2.x kernel


