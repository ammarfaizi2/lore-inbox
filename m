Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262430AbSJESRp>; Sat, 5 Oct 2002 14:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262431AbSJESRp>; Sat, 5 Oct 2002 14:17:45 -0400
Received: from borg1.zianet.com ([216.234.192.105]:20492 "HELO
	mesatop.zianet.com") by vger.kernel.org with SMTP
	id <S262430AbSJESRp>; Sat, 5 Oct 2002 14:17:45 -0400
Subject: Re: 2.5 Problem Report Status
From: Steven Cole <elenstev@mesatop.com>
To: Thomas Molina <tmolina@cox.net>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 05 Oct 2002 12:18:10 -0600
Message-Id: <1033841892.2353.13.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Molina wrote:

> additional report      01 Oct 2002 also in 2.5.40
> 20. http://marc.theaimsgroup.com/?l=linux-kernel&m=103343520729702&w=2
>
>Several people have reported oops on boot in device_attach.  It may be 
>related to isapnp, but that is not confirmed.

I reported the above oops was fixed for me here:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103349300620391&w=2

The new oops on boot for 2.5.39 which I referred to in that message,
and which I also reported for 2.5.40 here:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103350518802833&w=2

has been fixed (for me anyway) in 2.5.40-ac3.

Thanks,
Steven

