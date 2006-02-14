Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030358AbWBNIIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030358AbWBNIIR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 03:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030487AbWBNIIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 03:08:17 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:24478 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1030358AbWBNIIQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 03:08:16 -0500
Date: Tue, 14 Feb 2006 09:08:08 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
cc: peter.read@gmail.com, mj@ucw.cz, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net,
       jerome.lacoste@gmail.com, dhazelton@enter.net
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
In-Reply-To: <43F0B52B.nailMBX1DK2ST@burner>
Message-ID: <Pine.LNX.4.61.0602140906200.7198@yvahk01.tjqt.qr>
References: <20060208162828.GA17534@voodoo> <20060210114721.GB20093@merlin.emma.line.org>
 <43EC887B.nailISDGC9CP5@burner> <200602090757.13767.dhazelton@enter.net>
 <43EC8F22.nailISDL17DJF@burner> <5a2cf1f60602100738r465dd996m2ddc8ef18bf1b716@mail.gmail.com>
 <43F06220.nailKUS5D8SL2@burner> <mj+md-20060213.104344.18941.atrey@ucw.cz>
 <43F09E67.nailKUSQCAD6I@burner> <Pine.LNX.4.61.0602131728530.24297@yvahk01.tjqt.qr>
 <43F0B52B.nailMBX1DK2ST@burner>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >
>> >On Solaris, adding a new controler always asigns this new controler a new
>> >higher ID (except for the case when the sysadmin explicitly requests different 
>> >behavior).
>>
>> What if the OS runs out of next-higher IDs?
>
>????
>
>Do you believe that an int32_t is not sufficient?
>

I can replug some media in and out repeatedly, maybe even use software to 
do so. (stuff like sdparm -C eject on USB flash media do their thing)
The problem exists. You play it down like one does not need to check 
malloc() for NULL just because "there's probably enough memory" when the 
superuser started this process... I mean, it sounds like that.


Jan Engelhardt
-- 
