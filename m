Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265276AbTBUBjI>; Thu, 20 Feb 2003 20:39:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267034AbTBUBjI>; Thu, 20 Feb 2003 20:39:08 -0500
Received: from virtisp1.zianet.com ([216.234.192.105]:61956 "HELO
	mesatop.zianet.com") by vger.kernel.org with SMTP
	id <S265276AbTBUBjH>; Thu, 20 Feb 2003 20:39:07 -0500
Subject: Re: Linux 2.5.62-ac1
From: Steven Cole <elenstev@mesatop.com>
To: Alan Cox <alan@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200302202357.h1KNvXo29517@devserv.devel.redhat.com>
References: <200302202357.h1KNvXo29517@devserv.devel.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 20 Feb 2003 18:48:50 -0700
Message-Id: <1045792132.5965.521.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-02-20 at 16:57, Alan Cox wrote:
> > ide_xlate_1024+0xf5
> > read_dev_sector+0x69
> > handle_ide_mess+0x179
> 
> Ok I broke it with the change to the partiton stuff I put back. If you drop
> that partition tweak out it ought to boot.
> 
I'll try that tomorrow morning (12 hours from now) when I have access to that machine.

Thanks,
Steven

