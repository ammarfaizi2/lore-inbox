Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262170AbVEYQql@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262170AbVEYQql (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 12:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261493AbVEYQqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 12:46:35 -0400
Received: from whirlwind.atmosp.physics.utoronto.ca ([128.100.80.80]:36160
	"EHLO whirlwind.atmosp.physics.utoronto.ca") by vger.kernel.org
	with ESMTP id S261479AbVEYQp7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 12:45:59 -0400
Date: Wed, 25 May 2005 12:45:23 -0400
From: Alexey Koptsevich <kopts@atmosp.physics.utoronto.ca>
To: linux-kernel@vger.kernel.org
Subject: delay at starting udev
Message-ID: <Pine.SGI.4.60.0505171406020.13898958@whirlwind.atmosp.physics.utoronto.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I experience a major delay (about 5 min on dual CPU 3GHz machine, RedHat 
AS v4) at system boot-up at the point of "Starting udev:". The references 
to it I was able to find say that it was fixed in udev releases years ago. 
Is anything known about this problem?

> uname -a
Linux <...> 2.6.11.7 #2 SMP Tue Apr 19 16:46:25 EDT 2005 i686 i686 i386 GNU/Linux

>rpm -q udev
udev-039-10.8.EL4

Any help is greatly appreciated!

Thanks,
Alex
