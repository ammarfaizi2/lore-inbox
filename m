Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266490AbRGGPfJ>; Sat, 7 Jul 2001 11:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266493AbRGGPeu>; Sat, 7 Jul 2001 11:34:50 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:38600 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S266490AbRGGPed>;
	Sat, 7 Jul 2001 11:34:33 -0400
Message-ID: <3B472C06.78A9530C@mandrakesoft.com>
Date: Sat, 07 Jul 2001 11:34:30 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: viro@math.psu.edu
Subject: RFC: Remove swap file support
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since you can make any file into a block device using loop,
is there any value to supporting swap files in 2.5?

swap files seem like a special case that is no longer necessary...

-- 
Jeff Garzik      | A recent study has shown that too much soup
Building 1024    | can cause malaise in laboratory mice.
MandrakeSoft     |
