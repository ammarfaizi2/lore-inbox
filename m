Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262253AbUDDICY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 04:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbUDDICX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 04:02:23 -0400
Received: from webmail.sub.ru ([213.247.139.22]:22021 "HELO techno.sub.ru")
	by vger.kernel.org with SMTP id S262253AbUDDICU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 04:02:20 -0400
Subject: Re: 2.6.4 : 100% CPU use on EIDE disk operarion, VIA chipset
From: Mikhail Ramendik <mr@ramendik.ru>
To: Andreas Hartmann <andihartmann@freenet.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <406E9EE5.7030509@A88a2.a.pppool.de>
References: <fa.ld6rcgc.1lhmd9q@ifi.uio.no>
	 <406E9EE5.7030509@A88a2.a.pppool.de>
Content-Type: text/plain
Message-Id: <1081065734.1073.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-6aspMR) 
Date: Sun, 04 Apr 2004 12:02:14 +0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Andreas Hartmann wrote:

> > It turned out that on disk-intensive operation, the "system" CPU usage
> > skyrockets. With a mere "cp" of a large file to the same direstory
> > (tested with ext3fs and FAT32 file systems), it is 100% practically all
> > of the time !
> But you're right, 2.6.4 is slower than 2.4.25. See the thread "Very poor 
> performance with 2.6.4" here in the list.

As recommended there, I have tried 2.6.5-rc3-mm4.

No change. Still 100% CPU usage; the performance seems teh same.

Yours, Mikhail Ramendik

P.S. Sorry for making all comments into answers to your letter. I just
don't want to break the thread. 




