Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261774AbUKAMix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbUKAMix (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 07:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbUKAMhC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 07:37:02 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:12215 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261774AbUKAMge (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 07:36:34 -0500
Date: Mon, 1 Nov 2004 13:36:28 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Z Smith <plinius@comcast.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: code bloat [was Re: Semaphore assembly-code bug]
In-Reply-To: <1099308563.18808.62.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.53.0411011335300.25472@yvahk01.tjqt.qr>
References: <417550FB.8020404@drdos.com.suse.lists.linux.kernel> 
 <200410310000.38019.vda@port.imtp.ilyichevsk.odessa.ua> 
 <1099170891.1424.1.camel@krustophenia.net>  <200410310111.07086.vda@port.imtp.ilyichevsk.odessa.ua>
  <20041030222720.GA22753@hockin.org>  <Pine.LNX.4.53.0410310744210.3581@yvahk01.tjqt.qr>
  <41855483.2090906@comcast.net>  <Pine.LNX.4.53.0410312213080.18107@yvahk01.tjqt.qr>
 <1099308563.18808.62.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Whatever you do, 3D at the software level is slow, even with a fast comp.
>> See MESA.
>
>If you are willing to lose a few bits of OpenGL you can do 3D pretty
>fast in software for gaming. Take a look at stuff like TinyGL

Ok, you're right. But to be honest, it does not need to be GL. Just look at
UnrealTournament (runs fine on a PII W98 w/233MHz, in software mode!)



Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
