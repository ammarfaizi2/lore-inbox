Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268477AbTANB2H>; Mon, 13 Jan 2003 20:28:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268479AbTANB2G>; Mon, 13 Jan 2003 20:28:06 -0500
Received: from 216-239-45-4.google.com ([216.239.45.4]:63260 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id <S268477AbTANB2E>; Mon, 13 Jan 2003 20:28:04 -0500
Message-ID: <3E23696A.9040006@google.com>
Date: Mon, 13 Jan 2003 17:35:38 -0800
From: Ross Biro <rossb@google.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ross Biro <rossb@google.com>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Alan Cox <alan@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-pre3-ac4
References: <200301121807.h0CI7Qp04542@devserv.devel.redhat.com>	 <1042399796.525.215.camel@zion.wanadoo.fr>	 <1042403235.16288.14.camel@irongate.swansea.linux.org.uk>	 <1042401074.525.219.camel@zion.wanadoo.fr>  <3E230A4D.6020706@google.com>	 <1042484609.30837.31.camel@zion.wanadoo.fr>  <3E23114E.8070400@google.com> <1042491409.586.4.camel@zion.wanadoo.fr> <3E233160.3040901@google.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ross Biro wrote:

>>>
>>> This is technically a spec violation, but it's probably safe.  I'm 
>>> going to send an email to a couple of the drive manufacturers and 
>>> see what they think.
>>>   
>>
I just heard back from one ide controller chip vendor and they think we 
should disable PCI write posting.  From the tone of the response, I 
believe that they may not have thought of this before and it may be a 
problem in their non-opensource drivers as well.

    Ross


