Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751278AbVLIGMQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbVLIGMQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 01:12:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbVLIGMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 01:12:16 -0500
Received: from ns2.lanforge.com ([66.165.47.211]:28060 "EHLO ns2.lanforge.com")
	by vger.kernel.org with ESMTP id S1751278AbVLIGMP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 01:12:15 -0500
Message-ID: <4399203C.6030401@candelatech.com>
Date: Thu, 08 Dec 2005 22:12:12 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux in a binary world... a doomsday scenario
References: <200512081932.jB8JWkfN020116@pincoya.inf.utfsm.cl> <Pine.LNX.4.61.0512081606280.15436@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0512081606280.15436@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:

> Talk about rock-bottom stuff, does anybody know if I can build
> a file-system on a CompactFlash card that plugs into a USB adapter
> from Linux (like those marketed by Kodak) ??

If you're talking about one of those 15-in-one card readers...

Yes..it shows up like a normal USB storage block device.  I use one of
those things to copy 512MB CF disks using 'dd' often...

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

