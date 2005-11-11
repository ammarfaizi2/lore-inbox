Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751118AbVKKTtb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbVKKTtb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 14:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbVKKTta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 14:49:30 -0500
Received: from rtsoft2.corbina.net ([85.21.88.2]:13735 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S1751117AbVKKTta
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 14:49:30 -0500
Message-ID: <4374F633.6020006@ru.mvista.com>
Date: Fri, 11 Nov 2005 22:51:15 +0300
From: Sergei Shtylylov <sshtylyov@ru.mvista.com>
Organization: MostaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: linux-ide@vger.kernel.org
CC: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Highpoint IDE types
References: <1131471483.25192.76.camel@localhost.localdomain> <pan.2005.11.08.19.02.09.190896@sci.fi>
In-Reply-To: <pan.2005.11.08.19.02.09.190896@sci.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Ville Syrjälä wrote:
> On Tue, 08 Nov 2005 17:38:02 +0000, Alan Cox wrote:

>>Ok thanks to Sergei I can now post what I think is the complete table of
>>HPT chip versions:

    Another correction coming in... :-)

>>        Chip                    PCI ID          Rev
>> *      HPT366                  4 (HPT366)      0
>> *      HPT366                  4 (HPT366)      1    
>> *      HPT368                  4 (HPT366)      2      
>> *      HPT370                  4 (HPT366)      3      
>> *      HPT370A                 4 (HPT366)      4      
>> *      HPT372                  4 (HPT366)      5     
>> *      HPT372N                 4 (HPT366)      6     
>> *      HPT372                  5 (HPT372)      0
> 
>           ^^^^^^
> 
> This one is called HPT372A by Highpoint's BIOS/Win drivers.

    According to Highpoint's driver code 372A has rev. ID 1...

> Also I'm not sure if it's relevant but PCI ID 5 chips use a different
> BIOS image than PCI ID 4 chips.
>        
> 
>> *      HPT372N                 5 (HPT372)      > 0     

    And 372N has rev. ID 2...

WBR, Sergei
