Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263997AbTGXNIm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 09:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264067AbTGXNIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 09:08:42 -0400
Received: from fep03-mail.bloor.is.net.cable.rogers.com ([66.185.86.73]:57515
	"EHLO fep03-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S263997AbTGXNIl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 09:08:41 -0400
Message-ID: <3F1FE06A.5030305@rogers.com>
Date: Thu, 24 Jul 2003 09:34:34 -0400
From: gaxt <gaxt@rogers.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030708 Thunderbird/0.1a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Firewire
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at fep03-mail.bloor.is.net.cable.rogers.com from [24.157.78.60] using ID <dw2price@rogers.com> at Thu, 24 Jul 2003 09:23:49 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does anyone have firewire running on Linux 2.6.0-test1-mm2 ?

This is what dmesg reports after boot. If I plug in an iPod and use 
sbp2, I can mount the iPod as a disk and look at its files but using 
gtkpod freezes up the machine.

ieee1394: unsolicited response packet received - np
ieee1394: contents: ffc00160 ffc00000 00000000 dee10404
ieee1394: unsolicited response packet received - np
ieee1394: contents: ffc00560 ffc00000 00000000 dee10404
ieee1394: unsolicited response packet received - np
ieee1394: contents: ffc00960 ffc00000 00000000 dee10404
ieee1394: ConfigROM quadlet transaction error for node 00:1023

