Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750754AbWFGNCu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbWFGNCu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 09:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbWFGNCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 09:02:50 -0400
Received: from smtpout08-04.prod.mesa1.secureserver.net ([64.202.165.12]:18150
	"HELO smtpout08-04.prod.mesa1.secureserver.net") by vger.kernel.org
	with SMTP id S1750754AbWFGNCt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 09:02:49 -0400
Message-ID: <4486CE78.2040506@seclark.us>
Date: Wed, 07 Jun 2006 09:02:48 -0400
From: Stephen Clark <Stephen.Clark@seclark.us>
Reply-To: Stephen.Clark@seclark.us
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22smp i686; en-US; m18) Gecko/20010110 Netscape6/6.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: usb error? linux 2.6.15-1.1831_FC4
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello List,


Anyone have an idea how I could fix this - I plugged in an ActionTec 
dualpc modem
configured so it would ask for a new flash. Where do I put the 
cxacru-fw.bin file?

Jun  3 17:43:16 joker kernel: usb 1-2: new full speed USB device using 
uhci_hcd
and address 65
Jun  3 17:43:16 joker kernel: NET: Registered protocol family 8
Jun  3 17:43:16 joker kernel: NET: Registered protocol family 20
Jun  3 17:43:18 joker kernel: usbcore: registered new driver cxacru
Jun  3 17:43:19 joker kernel: cxacru 1-2:1.0: firmware (cxacru-fw.bin) 
unavailab
le (hotplug misconfiguration?)

Thanks,
Steve

-- 

"They that give up essential liberty to obtain temporary safety, 
deserve neither liberty nor safety."  (Ben Franklin)

"The course of history shows that as a government grows, liberty 
decreases."  (Thomas Jefferson)



