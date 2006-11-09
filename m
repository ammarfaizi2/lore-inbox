Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965963AbWKIMXx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965963AbWKIMXx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 07:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965467AbWKIMXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 07:23:52 -0500
Received: from mail.tmr.com ([64.65.253.246]:42911 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S965369AbWKIMXv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 07:23:51 -0500
Message-ID: <45531E80.7010908@tmr.com>
Date: Thu, 09 Nov 2006 07:26:40 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Andrew Lyon <andrew.lyon@gmail.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
Subject: Re: Problems with Samsung SH-W163A SATA CD/DVDRW JMicron	20360/20363
 2.6.18.1
References: <f4527be0611081117x4f7610e1wc4aacbbfdcd6993a@mail.gmail.com> <1163017437.23956.73.camel@localhost.localdomain>
In-Reply-To: <1163017437.23956.73.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>Several people are reporting problems with AHCI and CD burning - are all
>the people concerned seeing this with Jmicron controllers or with other
>cases too ?
>
Now that you say that, I did have problems in the May-June time frame 
with AHCI. The machine has since been redeployed, but I doubt that it 
was a Jmicron controller, it was whatever Dell was shipping when 
Pentium-II was still in use. I dropped in a new UHCI card and the 
problems went away.

Andrew, I don't know if using another interface is an option for you, 
but it might be useful information if you could try.

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

