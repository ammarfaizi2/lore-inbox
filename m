Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265046AbSJWPD5>; Wed, 23 Oct 2002 11:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265047AbSJWPD5>; Wed, 23 Oct 2002 11:03:57 -0400
Received: from magic.adaptec.com ([208.236.45.80]:57508 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP
	id <S265046AbSJWPDz>; Wed, 23 Oct 2002 11:03:55 -0400
Date: Wed, 23 Oct 2002 09:09:37 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: vda@port.imtp.ilyichevsk.odessa.ua
cc: linux-kernel@vger.kernel.org
Subject: Re: EISA AIC7XXX not detected
Message-ID: <365640000.1035385777@aslan.btc.adaptec.com>
In-Reply-To: <200210231448.g9NEmJp04017@Port.imtp.ilyichevsk.odessa.ua>
References: <200210231448.g9NEmJp04017@Port.imtp.ilyichevsk.odessa.ua>
X-Mailer: Mulberry/3.0.0a4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
> 
> I have an oldie Pentium 66 box which was running OS/2
> for a very long time. Probably the last OS/2 box in our town :)
> 
> I want to convert it into backup web server.
> 
> The problem is that it does not see its disks when I boot Linux.
> Currently I'm running it in NFS root mode, but 16MB RAM is not
> much fun without swap :(
> 
> I'd like to stick printks here and there in driver source,
> thought you may have some advice.

Since you seem to have enabled the EISA/VLB probe in your config,
I don't know why your controller is not probed.

--
Justin

