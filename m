Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261346AbUK0Vog@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbUK0Vog (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 16:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261343AbUK0Vog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 16:44:36 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:32705 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261345AbUK0Vob (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 16:44:31 -0500
Date: Sat, 27 Nov 2004 22:44:24 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: RE: no entropy and no output at /dev/random  (quick question)
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKIEKEABAB.davids@webmaster.com>
Message-ID: <Pine.LNX.4.53.0411272244040.5879@yvahk01.tjqt.qr>
References: <MDEHLPKNGKAHNMBLJOLKIEKEABAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Timer, ok. But network - only if you are in full control of the network
>> segment the system is attached to which may be the case for your private
>> network but usually you can't predict what network traffic is actually
>> going on.
>
>	You would need a lot more than that to predict the TSC value when a packet
>is received. All kinds of unpredictable elements get mixed in, such as the
>offset between the network's timing source and the processor's as well as
>the cache efficiency in getting the networking code running to the point
>that it checks the TSC.

Sounds like I started a hell of a discussion (again) :)



Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
