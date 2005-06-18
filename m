Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262211AbVFSAXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262211AbVFSAXn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 20:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262213AbVFSAXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 20:23:42 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:25043
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S262211AbVFSAXZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 20:23:25 -0400
Message-ID: <42B4ACB1.7030807@linuxwireless.org>
Date: Sat, 18 Jun 2005 18:22:25 -0500
From: Alejandro Bonilla <abonilla@linuxwireless.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Lars Roland <lroland@gmail.com>
CC: Lincoln Dale <ltd@cisco.com>, Valdis.Kletnieks@vt.edu,
       Christian Kujau <evil@g-house.de>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: tg3 in 2.6.12-rc6 and Cisco PIX SMTP fixup
References: <001f01c57341$1802c3b0$600cc60a@amer.sykes.com>	 <200506171352.j5HDqpE8006543@turing-police.cc.vt.edu>	 <42B353B7.4070503@cisco.com> <4ad99e05050617222966671e4f@mail.gmail.com>
In-Reply-To: <4ad99e05050617222966671e4f@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lars Roland wrote:

>On 6/18/05, Lincoln Dale <ltd@cisco.com> wrote:
>  
>
>>there _was_ a bug in the Cisco PIX whereby it cleared TCP window-scaling
>>bits.
>>this can be tracked through cisco bug-id CSCdy29514.
>>
>>this was fixed back in August 2002 with the fix incorporated into PIX
>>software releases 6.1.5 and 6.2.3 and later.
>>any 'recent' (i.e. last 2.5 years) releases don't have this problem.
>>(or, at least, we don't think so..).
>>    
>>
>
>I have identified two firewalls with this problem and both of then are
>running PIX software version 6.3.4 - I have not yet managed to
>persuade there respective admins to update to 7.0.1 (or 6.3.4.115) -
>so until then I am just turning window-scaling off.
>  
>

If you have a Cisco contract, you need to make sure that your account 
manager will allow the upgrades.

But as I said before, this was fixed long time ago.

I hope you can upgrade soon.

.Alejandro

>
>
>Regards.
>
>Lars Roland
>  
>

