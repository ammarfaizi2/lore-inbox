Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261494AbUKSQsA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261494AbUKSQsA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 11:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbUKSQsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 11:48:00 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:32669 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261494AbUKSQpa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 11:45:30 -0500
Date: Fri, 19 Nov 2004 17:45:22 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
cc: linux dude <dude_linux@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9
In-Reply-To: <Pine.LNX.4.61.0411190912360.7201@musoma.fsmlabs.com>
Message-ID: <Pine.LNX.4.53.0411191742560.14261@yvahk01.tjqt.qr>
References: <20041119091240.4927.qmail@web90006.mail.scd.yahoo.com>
 <Pine.LNX.4.61.0411190912360.7201@musoma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> My question is I already did make odlconfig;make;make
>> modules;make modules_install; updated grub,image,
>> system.map. Is there any thing missing because of

You first update the image, then the system.map and then the bootloader.

>> which
>> it is trying to load module from old
>> /lib/modules/2.6.4-52/....
>> And Why it is not picking up from 2.6.9/.../ .

Don't LILO / GRUB show you which kernel you are booting? Did not you give them
some meaningful name?


Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
