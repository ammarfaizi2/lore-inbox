Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262620AbSKYIBv>; Mon, 25 Nov 2002 03:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262631AbSKYIBv>; Mon, 25 Nov 2002 03:01:51 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:60681 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S262620AbSKYIBu>; Mon, 25 Nov 2002 03:01:50 -0500
Message-ID: <3DE1DAB3.A3508E9C@aitel.hist.no>
Date: Mon, 25 Nov 2002 09:09:23 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.47 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: "Milton D. Miller II" <miltonm@realtime.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.48-bk4 still impossible to mount root.
References: <200211222115.gAMLFJe68953@sullivan.realtime.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Milton D. Miller II" wrote:
> 
> Maybe this patch has some merit?
> 
> http://www.ussg.iu.edu/hypermail/linux/kernel/0211.2/0495.html
> The patch perports to fix the case where getdirents on a directory takes
> more than 512 bytes for the result.

Maybe, but the patch claims to fix initrd problems, and I'm
not using an initrd yet.  I'll mount root directly as
long as the kernel supports it.
Thanks anyway, it might be worth a try.

Helge Hafting
