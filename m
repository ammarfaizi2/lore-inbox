Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261394AbSIXPQz>; Tue, 24 Sep 2002 11:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261418AbSIXPQz>; Tue, 24 Sep 2002 11:16:55 -0400
Received: from [202.64.97.34] ([202.64.97.34]:5386 "EHLO main.coppice.org")
	by vger.kernel.org with ESMTP id <S261394AbSIXPQz>;
	Tue, 24 Sep 2002 11:16:55 -0400
Message-ID: <3D90831A.7060709@coppice.org>
Date: Tue, 24 Sep 2002 23:22:02 +0800
From: Steve Underwood <steveu@coppice.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2a) Gecko/20020911
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: USB IEEE1284 gadgets and ppdev
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Can the USB driver for USB to IEEE1284 gadgets be used with the ppdev 
interface? I looked through the documentation and couldn't find a 
mention of this one way or the other. The structures used by parport and 
the USB stuff look similar, but I couldn't see how to get ppdev to play 
with the USB driver.

The documentation tells you how to do this using the special driver for 
those USB to IEEE1284 devices using the USS720 chip, but I have yet to 
see anything using that available for sale in these parts.

Regards,
Steve

