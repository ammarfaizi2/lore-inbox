Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136795AbREIRxJ>; Wed, 9 May 2001 13:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136789AbREIRw4>; Wed, 9 May 2001 13:52:56 -0400
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:15369 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S136787AbREIRvI>; Wed, 9 May 2001 13:51:08 -0400
Message-ID: <3AF98388.832CF843@delusion.de>
Date: Wed, 09 May 2001 19:51:04 +0200
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-ac6 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: USB Problem with reenabling hub
In-Reply-To: <mailman.989413441.16162.linux-kernel2news@redhat.com> <200105091712.f49HCt005184@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev wrote:
> 
> > switching it back on, a problem occurs with reenabling the ports on
> > that USB hub. The kernel output follows.
> 
> > Comments anyone?
> 
> Next time, post your /proc/version.

I thought this was unnecessary in this case, because my mail headers
nicely reveal which version it is, but here it is anyways ;):

/proc/version
Linux version 2.4.4-ac6 (root@Corona) (gcc version 2.95.3 20010315 (release)) #1

> There were similar things recently (missing urb->dev
> reinitialization in usb_hub_reset).

If more info is required or someone has a patch to try, please let me know.

Regards,
Udo.
