Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129868AbRALCup>; Thu, 11 Jan 2001 21:50:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130075AbRALCue>; Thu, 11 Jan 2001 21:50:34 -0500
Received: from f214.law3.hotmail.com ([209.185.241.214]:28686 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id <S129868AbRALCu1>;
	Thu, 11 Jan 2001 21:50:27 -0500
X-Originating-IP: [204.68.140.35]
From: "Jim M." <msg124@hotmail.com>
To: guinness-list@redhat.com, redhat-install-list@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [depmod] question
Date: Fri, 12 Jan 2001 02:50:21 -0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F214Cps4UlNv3ViZN9U00013ded@hotmail.com>
X-OriginalArrivalTime: 12 Jan 2001 02:50:21.0735 (UTC) FILETIME=[67C9FB70:01C07C42]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
I have kernel verison 2.2.14-12 version with RH6.2.
I do "cd /sbin" and i see "depmod" there in the /sbin
directory. But somehow seems like load module is not
working. Maybe this is the reason why system freezes happen
in my RH. A driver for a custom built pci card is not
loaded properly. Maybe i should do "/sbin/modprobe pci.driver"
manually or put it in my rc.local file. Please clarify if possible.
Thanks in advance.
J
_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
