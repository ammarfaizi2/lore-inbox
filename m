Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261368AbUJaVEq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbUJaVEq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 16:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261435AbUJaVEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 16:04:45 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:46079 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261368AbUJaVEa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 16:04:30 -0500
Message-ID: <41855483.2090906@comcast.net>
Date: Sun, 31 Oct 2004 13:09:23 -0800
From: Z Smith <plinius@comcast.net>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: code bloat [was Re: Semaphore assembly-code bug]
References: <417550FB.8020404@drdos.com.suse.lists.linux.kernel> <200410310000.38019.vda@port.imtp.ilyichevsk.odessa.ua> <1099170891.1424.1.camel@krustophenia.net> <200410310111.07086.vda@port.imtp.ilyichevsk.odessa.ua> <20041030222720.GA22753@hockin.org> <Pine.LNX.4.53.0410310744210.3581@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.53.0410310744210.3581@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:

> FBUI does not have 3d acceleration?

The problem is 3d non-acceleration i.e. VESA and VGA
would still have to be supported. I'm no 3d expert but
I think there must be some software-based 3d function
would require using floating point, which isn't allowed
in the kernel.

Also, might not software 3d open the kernel up to
patent issues?

Zachary Smith
