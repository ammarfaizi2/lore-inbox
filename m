Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263555AbUJ3Fks@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263555AbUJ3Fks (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 01:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263597AbUJ3Fks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 01:40:48 -0400
Received: from leviathan.kumin.ne.jp ([211.9.65.12]:8883 "HELO
	emerald.kumin.ne.jp") by vger.kernel.org with SMTP id S263555AbUJ3Fkj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 01:40:39 -0400
Message-Id: <200410300540.AA00005@prism.kumin.ne.jp>
Date: Sat, 30 Oct 2004 14:40:28 +0900
To: linux-kernel@vger.kernel.org
Cc: Jeff Garzik <jgarzik@pobox.com>, Netdev <netdev@oss.sgi.com>,
       Terje Kvernes <terjekv@math.uio.no>
Subject: Re: linux-2.6.9 eepro100 warning
From: Seiichi Nakashima <nakasima@kumin.ne.jp>
In-Reply-To: <wxxekjiq21q.fsf@nommo.uio.no>
References: <wxxekjiq21q.fsf@nommo.uio.no>
MIME-Version: 1.0
X-Mailer: AL-Mail32 Version 1.13
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks.

I update a kernel's parameter from eepro100 to PRO/100.
linux-2.6.9 work fine.

==

>
>  [ ... ]
>
>> If there are e100 problems, report them to the maintainers so we can
>> get them resolved ASAP...
>
>  I got a very nice mail from Jesse Brandeburg saying pretty much the
>  same thing...  so, I've pushed kernels for around 75 boxen over to
>  e100 today, from eepro100.  I'm not _quite_ sure when I'll have the
>  chance to boot them all, but when they do, and if they have
>  problems, I'll report back.
> 
>> INTEL PRO/100 ETHERNET SUPPORT
>> P:      John Ronciak
>> M:      john.ronciak@intel.com
>> P:      Ganesh Venkatesan
>> M:      ganesh.venkatesan@intel.com
>> P:      Scott Feldman
>> M:      scott.feldman@intel.com
>> W:      http://sourceforge.net/projects/e1000/
>> S:      Supported
>> 
>> (and of course netdev@oss.sgi.com as well)
>
>  ack.
>
>-- 
>Terje - still waiting to test hotswap SATA.   =)
>
>
--------------------------------
  Seiichi Nakashima
  Email   nakasima@kumin.ne.jp
--------------------------------
