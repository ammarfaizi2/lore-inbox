Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318516AbSH1CPa>; Tue, 27 Aug 2002 22:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318539AbSH1CPa>; Tue, 27 Aug 2002 22:15:30 -0400
Received: from smtp0.adl1.internode.on.net ([203.16.214.194]:62736 "EHLO
	fep.internode.on.net") by vger.kernel.org with ESMTP
	id <S318516AbSH1CP3>; Tue, 27 Aug 2002 22:15:29 -0400
Message-ID: <3D6C3357.50206@voicetronix.com.au>
Date: Wed, 28 Aug 2002 11:50:07 +0930
From: Peter Wintulich <peter@voicetronix.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re-detection/initialisation of PLX based PCI card 
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am not shure that this is the correct list for my question.

I am trying to find out how to re initalise a pci card after its 
identity has been programmed in. I think this could be similar to hot 
plug PCI functions but have no experience with this.

We currently reboot the computer after running insmod with a module that 
programs the identity eeprom attached to a PLX 9050 PCI bus interface 
chip. We then run production testing.

Any assistance would be wellcome, How to or where to look etc.

Thankyou in advance.

Peter Wintulich

-- 
peter@voicetronix.com.au

Peter Wintulich
VoiceTronix
Powering Open Telephony
Ph . +61 8 8415 5108
Fax. +61 8 8415 5107
www.voicetronix.com.au


