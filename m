Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264491AbTE1DkH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 23:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264492AbTE1DkH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 23:40:07 -0400
Received: from garnet.acns.fsu.edu ([146.201.2.25]:63953 "EHLO
	garnet.acns.fsu.edu") by vger.kernel.org with ESMTP id S264491AbTE1DkH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 23:40:07 -0400
Message-ID: <3ED43294.40808@cox.net>
Date: Tue, 27 May 2003 23:52:52 -0400
From: David van Hoose <davidvh@cox.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Is ALSA broken in 2.5.70?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can anyone help me figure out why ALSA is not working on my 2.5.70-bk1 
setup? I tried ALSA 0.9.2 with 2.4.21-rc5 and it worked. I tried 0.9.3c 
with 2.4.21-rc5 and it didn't work. I'm thinking I did not catch 
something important in the last change.
I'm running RedHat 9 with KDE as my desktop.
I have a AC'97 CMI9739A SiS7012 onboard sound device.
I am using the intel8x0 driver. Everything is configured as defined in 
the ALSA Documentation in the kernel doc directory. I also looked for 
more help from the ALSA site, but I can't find any help.
Has anyone gotten it to work under 2.5.70?
I have all of ALSA compiled as modules in my config except for pci 
modules which I only have the intel8x0 selection as a module.

Thanks,
David

