Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266078AbSLSSGK>; Thu, 19 Dec 2002 13:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266091AbSLSSGK>; Thu, 19 Dec 2002 13:06:10 -0500
Received: from 216-239-45-4.google.com ([216.239.45.4]:32782 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id <S266078AbSLSSGJ>; Thu, 19 Dec 2002 13:06:09 -0500
Message-ID: <3E020C16.607@google.com>
Date: Thu, 19 Dec 2002 10:12:38 -0800
From: Ross Biro <rossb@google.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: vda@port.imtp.ilyichevsk.odessa.ua
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, "D.A.M. Revok" <marvin@synapse.net>,
       Andre Hedrick <andre@linux-ide.org>,
       Manish Lachwani <manish@Zambeel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19, don't "hdparm -I /dev/hde" if hde is on a Asus A7V133
  Promise ctrlr, or...
References: <Pine.LNX.4.10.10212180241580.8350-100000@master.linux-ide.org> <200212181635.58164.marvin@synapse.net> <1040251122.26501.0.camel@irongate.swansea.linux.org.uk> <200212190951.gBJ9pCs28149@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:

>OTOH mere mortals are allowed to make full dump of PCI config ;)
>
>  
>
Some vendors use index/data registers in the config space, so unless you 
know of their existance, a PCI config dump doesn't help.

