Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751290AbVIGTbA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbVIGTbA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 15:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbVIGTbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 15:31:00 -0400
Received: from mail-out3.fuse.net ([216.68.8.176]:40703 "EHLO smtp3.fuse.net")
	by vger.kernel.org with ESMTP id S1751290AbVIGTbA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 15:31:00 -0400
Message-ID: <431E97E5.1080506@fuse.net>
Date: Wed, 07 Sep 2005 03:33:57 -0400
From: rob <rob.rice@fuse.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041221
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: swsusp
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I singed up to this mailing list just to ask this question
I have built a 2.6.13 kernel for a toshiba  tecra 500cdt
this computer uses the pci buss for the sound card
and pcmcia bridge
I have writen a script to unload all the pci buss modules amd go to sleep
it works up to this point
now how do I get the modules put back when ever I add the lines to
rerun the " /etc/rc.d/rc.hotplug /etc/rc.d/rc.pcmcia and 
/etc/rc.d/rcmodules "
I get a kernel crash befor it gose to sleep
I have been al over the net and the olny info I can find is about 
software suspend2
Is there some way to change the sowftware suspend2 scripts to work with the
unpatched kernel software suspend or where can I get the path to init
talked about in the menuconfig file
