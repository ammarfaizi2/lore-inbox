Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261320AbTDCQTe>; Thu, 3 Apr 2003 11:19:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261321AbTDCQTe>; Thu, 3 Apr 2003 11:19:34 -0500
Received: from denise.shiny.it ([194.20.232.1]:50578 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id <S261320AbTDCQTe>;
	Thu, 3 Apr 2003 11:19:34 -0500
Message-ID: <XFMail.20030403183058.pochini@shiny.it>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <3E8BFAA3.7010608@canada.com>
Date: Thu, 03 Apr 2003 18:30:58 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: Nehal <nehal@canada.com>
Subject: Re: mount hfs on SCSI cdrom = segfault
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>Once upon a time it worked just fine. Then someone removed
>>support for !=512 bytes sectors...
>>To workaround, use loopback.
>>
> (yes Oliver has told me about this workaround)
> 
> 1. do u know why it was removed?
> 2. is there a reason why can't support for it be put back?

I don't know why, and I don't know if it was removed from the
hfs code or if hfs relied on some features of a lower layer
that has been modified.


Bye.

