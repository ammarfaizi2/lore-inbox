Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270419AbTGQUE5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 16:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269296AbTGQUE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 16:04:56 -0400
Received: from twix.hotpop.com ([204.57.55.70]:57553 "EHLO twix.hotpop.com")
	by vger.kernel.org with ESMTP id S270419AbTGQUAL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 16:00:11 -0400
Message-ID: <3F170264.6030103@hotpop.com>
Date: Fri, 18 Jul 2003 01:39:08 +0530
From: dacin <dacin@hotpop.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Douglas J Hunley <doug@hunley.homeip.net>, linux-kernel@vger.kernel.org
Subject: Re: MONOLITHIC sound (was Re: 2.6 sound drivers?)
References: <20030716225826.GP2412@rdlg.net> <200307171308.54518.nbensa@gmx.net> <3F16EEFC.3000803@hotpop.com> <200307171513.00158.doug@hunley.homeip.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Douglas J Hunley wrote:

>-----BEGIN PGP SIGNED MESSAGE-----
>Hash: SHA1
>
>dacin shocked and awed us all by speaking:
>  
>
>>Ummm read this....
>>http://www.alsa-project.org/~valentyn/other-formats/Alsa-sound-mini-HOWTO.h
>>tml http://alsa.opensrc.org/index.php?page=emu10k1
>>http://alsa-project.org/alsa-doc/doc-php/template.php3?company=Creative+Lab
>>s&card=Soundblaster+Live&chip=EMU10K1&module=emu10k1
>>    
>>
>
>I too am trying the 2.6 kernel per Linus' desires and also have an SBLive! . 
>However, I absolutely *destest* kernel modules. To my knowledge, ALSA has 
>been exclusively module-oriented. I'm going to assume that in 2.6 you can 
>build ALSA into a monolithic kernel. Is this assumtion valid? If so, will the 
>referenced documents above apply to getting my sound working? Or are there 
>other documents/resources that I need to be reading to get non-modular ALSA 
>working? Thanks.
>- -- 
>
 lspci -v | grep audio
 02:0e.0 Multimedia audio controller: Creative Labs SB Live!   EMU10k1 
 (rev 08)

 Me checked ta alsa in 2.6.0-test1 as modules as well as inbuilt, it 
workz but nt rockz. Sound in mid
 freq is distorted, and yep all ta tone *bass/treble* do work.
 Ummm I don't think u need to read other documents *provided u did went 
thru it thoroughly*.
 
Dacodecz
=================================================================================
Crawling on ta shadow of darknezz.


