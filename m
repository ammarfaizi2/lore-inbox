Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262685AbSJBWws>; Wed, 2 Oct 2002 18:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262650AbSJBWws>; Wed, 2 Oct 2002 18:52:48 -0400
Received: from cp44749-a.roemd1.lb.home.nl ([217.121.99.54]:56317 "EHLO
	garion.edsons.demon.nl") by vger.kernel.org with ESMTP
	id <S262685AbSJBWwr>; Wed, 2 Oct 2002 18:52:47 -0400
Message-ID: <3D9B7B05.1080307@edsons.demon.nl>
Date: Thu, 03 Oct 2002 01:02:29 +0200
From: Rudy Zijlstra <rudy@edsons.demon.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2a) Gecko/20020910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, mec@shout.net
Subject: make menuconfig fail on 2.5.40
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

as requested by "make menuconfig" when it crahed out from under me, a 
report on the error it generated.

kernel to be configured: 2.5.40, unmodified from kernel.org
section: ALSA configuration
error: ./script/Menuconfig: MCmenu74: command not found

running system: Dual Athlon 1900 with SMP 2.4.19 kernel (slackware 8.1)

Cheers,

Rudy


