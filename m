Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316542AbSGAWOO>; Mon, 1 Jul 2002 18:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316545AbSGAWON>; Mon, 1 Jul 2002 18:14:13 -0400
Received: from nextgeneration.speedroad.net ([195.139.232.50]:31110 "HELO
	nextgeneration.speedroad.net") by vger.kernel.org with SMTP
	id <S316542AbSGAWON>; Mon, 1 Jul 2002 18:14:13 -0400
Message-ID: <20020701221651.10653.qmail@nextgeneration.speedroad.net>
References: <Pine.GSO.4.30.0207012214430.15254-200000@balu>
In-Reply-To: <Pine.GSO.4.30.0207012214430.15254-200000@balu> 
From: "Arnvid Karstad" <arnvid@karstad.org>
To: Pozsar Balazs <pozsy@uhulinux.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: HPT370 + ACPI -> freeze (doesn't boot)
Date: Tue, 02 Jul 2002 00:16:51 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hiya, 

Pozsar Balazs writes:
> I have an abit VP6 mobo with the integrated HPT370 ide-controller.
> If I enable ACPI support, and I connect any harddisk to the hpt host, my
> system locks up hard during boot while initializing the drive(s) on the
> hpt controller (ie. before printing the 'hde:...' line). The hard drive's
> led remains lit.

I have a similar system to yours, but I have drives only on the hpt370 
controller. My system boots, but crashes after 5 to 15 minuttes regardless 
of usage. (I've posted this to this list on a previous occation.) 

My system is running on dual P3-866 cpu's, but I don't think that this is of 
any importance to the configuration. I haven't really tried to run any 
patches. Do you have any similar problems when running a clean 2.4.18? Or 
does your system only freeze? 

> If I pass the 'acpi=off' option to the kernel, it does boot but obviously
> I don't have acpi support that way :(.

I haven't tried this. But my system is not exactly freezing, just I cant 
access the drives anymore. 


> Thanks for any help, I am willing to test any patches!

If u find anything that works, could you send me a note aswell? Since I've 
been wanting to run Linux on my machine for a while now and my systems seems 
to preform better when the drives are connected to the HPT370 than the other 
internal VIA ide controller. Atleast this is the 'general' feeling I have 
after experimenting with a few things under windows 2000 pro. 

Best regards, 

Arnvid Karstad 
