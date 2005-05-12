Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261344AbVELIuD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261344AbVELIuD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 04:50:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261355AbVELIsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 04:48:50 -0400
Received: from [202.27.213.9] ([202.27.213.9]:37381 "HELO kereru.org")
	by vger.kernel.org with SMTP id S261344AbVELIrb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 04:47:31 -0400
Message-ID: <3534.222.153.142.91.1115887645.squirrel@222.153.142.91>
Date: Thu, 12 May 2005 20:47:25 +1200 (New Zealand Standard Time)
Subject: Re: 2.6.11 USB broken on VIA computer (not just ACPI)
From: paul@kereru.org
To: linux-kernel@vger.kernel.org
Cc: paul@kereru.org
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Did it work OK under previous kernels?  If so, which versions?

I have a little more information on this...
I have a (quite) new EPIA MII 12000.
Worked fine on FC3 with 2.6.9. It also worked on 2.6.7.

Have installed KnoppMyth, which comes with 2.6.11.7-chw-4.
All my 2.0 USB ports now list as 1.1, and 2.0 devices plugged
in run at 1.1 speeds.

lspci reports:
    USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 80) (prog-if 00 [UHCI])
    Subsystem: VIA Technologies, Inc.: Unknown device aa01

Hope this helps (and makes it to you).
Paul.


