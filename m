Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131887AbRDDTKH>; Wed, 4 Apr 2001 15:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131886AbRDDTJ7>; Wed, 4 Apr 2001 15:09:59 -0400
Received: from dial127.za.nextra.sk ([195.168.64.127]:516 "HELO Boris.SHARK")
	by vger.kernel.org with SMTP id <S131873AbRDDTJn>;
	Wed, 4 Apr 2001 15:09:43 -0400
Date: Wed, 4 Apr 2001 13:21:32 +0200
From: Boris Pisarcik <boris@acheron.sk>
To: linux-kernel@vger.kernel.org
Subject: Re: Non keyboard trigger of Alt-SysRQ-S-U-B
Message-ID: <20010404132132.A791@Boris>
In-Reply-To: <3ABE1C70.92CBBF01@umr.edu> <6069.985558615@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <6069.985558615@ocs3.ocs-net>; from kaos@ocs.com.au on Mon, Mar 26, 2001 at 08:16:55AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If you have a serial console on the server, you can get sysrq by
> sending a serial break followed by the character. 

Hi,

i've tried it with minicom and functioned : ctrl+a+F and key for function
as in normal sysrq.

This approach will probably not help you a lot thought, since you wouldn't
have access to your serial console too.

If you don't get your problems solved till now, i could make a simple
single-purpos module which will export a syscall to priviledged process
to call sysrq functions.

Gonna to have a look...

Bye                                                                     B.

