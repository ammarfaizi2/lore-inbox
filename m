Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbTLVTiX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 14:38:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263751AbTLVTiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 14:38:23 -0500
Received: from fep03-mail.bloor.is.net.cable.rogers.com ([66.185.86.73]:44726
	"EHLO fep03-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S261190AbTLVTiW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 14:38:22 -0500
Message-ID: <3FE702A2.2090701@rogers.com>
Date: Mon, 22 Dec 2003 14:41:38 +0000
From: pZa1x <pZa1x@rogers.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.0 release + ALSA + suspend = not work
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at fep03-mail.bloor.is.net.cable.rogers.com from [24.157.208.226] using ID <dw2price@rogers.com> at Mon, 22 Dec 2003 14:37:56 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ALSA stops producing sound after any time I suspend my Thinkpad T20 
notebook. I am using 2.6.0 release and the snd-cs46xx driver.

I have to log out of Gnome and remove the sound card module and re 
modprobe it then restart Gnome to get sound back.

No problems with 2.4.20 with OSS drivers.

