Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932137AbVI2NiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbVI2NiZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 09:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbVI2NiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 09:38:25 -0400
Received: from paegas.mail-atlas.net ([212.47.13.186]:23560 "EHLO
	paegas.mail-atlas.net") by vger.kernel.org with ESMTP
	id S932137AbVI2NiY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 09:38:24 -0400
From: "janik holy" <divizion@pobox.sk>
To: linux-kernel@vger.kernel.org
Message-ID: <11ef658a67624a82b2b73decd6a78c07@pobox.sk>
Date: Thu, 29 Sep 2005 15:38:14 +0200
X-Priority: 3 (Normal)
Subject: pcmcia bug ?
MIME-Version: 1.0
Content-type: text/plain; charset=windows-1250
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, i use slack 10.1, kernel 2.6.14-rc2-git7, i have orinoco silver pcmcia wifi card, i compile PCMCIA support into kernel, and orinoco, hermes, orinoco_cs as modules.... after booting loading modules, and run /etc/rc.d/rc.pcmcia i see message >= cardmgr no pcmcia in /proc/devices. after cat /proc/devices there is really no pcmcia. I really dont know what is it, on 2.6.11 with the same kernel conf, its works ok and pcmcia was in /proc/devices. So during i wont have pcmcia in /proc/devices i cant use cardctl and cardmgr ... any idea how to fix it ? where can be a problem ? thanks 


Aktivujte si neobmedzenu mailovu schranku na www.pobox.sk!


