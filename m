Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130699AbRCIVbY>; Fri, 9 Mar 2001 16:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130702AbRCIVbO>; Fri, 9 Mar 2001 16:31:14 -0500
Received: from mail.surgient.com ([63.118.236.3]:2055 "EHLO
	bignorse.SURGIENT.COM") by vger.kernel.org with ESMTP
	id <S130699AbRCIVa5>; Fri, 9 Mar 2001 16:30:57 -0500
Message-ID: <A490B2C9C629944E85CE1F394138AF957FC400@bignorse.SURGIENT.COM>
From: "Collins, Tom" <Tom.Collins@Surgient.com>
To: linux-kernel@vger.kernel.org
Subject: processor time, process time, idle time, etc
Date: Fri, 9 Mar 2001 15:30:04 -0600 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-15"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello...

I am wondering is there is a way to obtain resource usage 
from the kernel w/o doing a kernel call from a program
(can I get this from /proc/??  ?).

For example, I am interested in discriminating between
processor idle time, time spent in processes, etc.

Is this possible, or will I have to get this accounting
information from the kernel via a module/system call?

Thanks

Tom 
