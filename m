Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263574AbUEKUMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263574AbUEKUMY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 16:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263582AbUEKUMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 16:12:24 -0400
Received: from alesia-4-82-66-59-64.fbx.proxad.net ([82.66.59.64]:62337 "HELO
	rooter.tripnotik.net") by vger.kernel.org with SMTP id S263574AbUEKUMV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 16:12:21 -0400
X-Qmail-Scanner-Mail-From: jdidron@tripnotik.net via rooter
X-Qmail-Scanner: 1.20 (Clear:RC:1(192.168.0.249):. Processed in 0.046021 secs)
Message-ID: <40A132FF.4090901@tripnotik.net>
Date: Tue, 11 May 2004 22:09:35 +0200
From: Julien Didron <jdidron@tripnotik.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: usb webcam problem
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello list,

    I'm experiencing this problem, using a QuickCam Zoom from you know 
who ... with the pwc driver :

    May 11 21:28:22 kisskool pwc Frame buffer underflow (4 bytes); 
discarded.
    May 11 21:28:22 kisskool pwc Closing video device: 75 frames 
received, dumped 0 frames, 71 frames with errors.

    Now, after contacting NemoSoft about this issue, it seems the 
problem might have to do with the OHCI driver.
   
    Here is my setup :
    Kernel 2.6.6 (but I also had this problem running kernels 2.6.4 & 
2.6.5, never tried with any other, also to mention that it is patched 
for use with a bootsplash).
    USB controller : Nforce2
    Mobo : A7N8X with AMD3200+

Thank you in advance for any help you might give me.

Julien

   
