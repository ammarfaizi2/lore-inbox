Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263012AbTDRKVH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 06:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263013AbTDRKVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 06:21:07 -0400
Received: from vsmtp4.tin.it ([212.216.176.224]:7599 "EHLO smtp4.cp.tin.it")
	by vger.kernel.org with ESMTP id S263012AbTDRKVH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 06:21:07 -0400
Message-ID: <3E9FD477.7000905@tin.it>
Date: Fri, 18 Apr 2003 12:33:27 +0200
From: Marci <voloterreno@tin.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: VT8235 CD-Writer Incompatibilities not completly solved
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all I've posted in the past a problem with some CD-Writers and DVD 
Readers and this Chipset that at the boot time delivers problem of 
timings and gives the message {TimeOut for Command} .

Vojtek Pavlik made some patches for the problem, and have said that 
these will be included in the 2.4.21 kernel release. Now, I've changed 
my CD-Writer, and I haven't this problem again, I've tried to change my 
CD-Writer again with my old one and I've tried to burn a CD , the result 
was the failure of the CD-Burning process. Now the system start 
correctly , the read works correctly too, but  the burning of CD's 
doesn't work again. Now, this isn't a problem for me (I've said that 
I've changed my CD-Writer) , but for other people that can have this 
problem I hope that you can tune some setting in the Source, in order to 
make this work

Thanks

Bye

Marcello

