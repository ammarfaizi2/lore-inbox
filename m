Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265020AbTGBORb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 10:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265023AbTGBORa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 10:17:30 -0400
Received: from va-leesburg1b-227.chvlva.adelphia.net ([68.64.41.227]:49892
	"EHLO ccs.covici.com") by vger.kernel.org with ESMTP
	id S265020AbTGBOR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 10:17:29 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.73 - Won't compile using oldconfig - config attached
References: <003201c33970$21f57280$0200a8c0@wsl3>
From: John Covici <covici@ccs.covici.com>
Date: Wed, 02 Jul 2003 10:31:53 -0400
In-Reply-To: <003201c33970$21f57280$0200a8c0@wsl3> (vlad@lrsehosting.com's
 message of "Mon, 23 Jun 2003 05:13:43 -0500")
Message-ID: <m3k7b12e5i.fsf@ccs.covici.com>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anyone have an answer to this one?  I am getting the same error as
below.

Its true I am using a .config from 70 and did make oldconfig -- if
this is the problem, how can I fix it?

Thanks.


on Mon, 23 Jun 2003 05:13:43 -0500 vlad@lrsehosting.com wrote:

> drivers/usb/host/ehci-hcd.c:977: pci_ids causes a section type conflict
> make[3]: *** [drivers/usb/host/ehci-hcd.o] Error 1
> make[2]: *** [drivers/usb/host] Error 2
> make[1]: *** [drivers/usb] Error 2
> make: *** [drivers] Error 2
>
>
>
> --
>

-- 
         John Covici
         covici@ccs.covici.com
