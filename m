Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266093AbTGKUjG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 16:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266266AbTGKUjG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 16:39:06 -0400
Received: from mail6.iserv.net ([204.177.184.156]:50874 "EHLO mail6.iserv.net")
	by vger.kernel.org with ESMTP id S266093AbTGKUjA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 16:39:00 -0400
Message-ID: <3F0F23CF.6010406@didntduck.org>
Date: Fri, 11 Jul 2003 16:53:35 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 'what to expect'
References: <20030711140219.GB16433@suse.de> <1057933578.20636.17.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1057933578.20636.17.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>>- Some people seem to have trouble running rpm, most notably Red Hat 9 users.
>>  This is a known bug of rpm.
>>  Workaround: run "export LD_ASSUME_KERNEL=2.2.5", before running rpm.
> 
> 
> or upgrade to rpm 4.2 (which I'd recommend everyone does anyway as it
> fixes a load of other problems) - ftp.rpm.org
> 

Still fails with rpm 4.2.1 from rawhide without the LD_ASSUME_KERNEL 
hack.  I haven't checked rpm.org yet, that site appears to be dead.

--
				Brian Gerst

