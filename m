Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267525AbUBTEdD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 23:33:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267524AbUBTEdD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 23:33:03 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:43745 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S267525AbUBTEdB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 23:33:01 -0500
Message-ID: <40358DFB.5010307@linuxmail.org>
Date: Thu, 19 Feb 2004 22:32:59 -0600
From: Perry Gilfillan <perrye@linuxmail.org>
Reply-To: perrye@linuxmail.org
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.5b) Gecko/20030827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: kernel <linux-kernel@vger.kernel.org>
Subject: [RFC] New driver for vpx3224 video pixel decoder
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've written a new driver for the vpx3224/5 chip's.  It is based on the 
structure of Laurent Pinchart's vpx3220 driver found in the 2.6 kernel, 
and the vpx322x driver from the v3tv.sourceforge.net project.

You can find it at http://gilfillan.org:8000/vpx3224/

I have three or four users reporting success at this time.

I've developed it on the 2.4 kernel.  The v3tv driver needs more work 
before I can test it on 2.6.  The changes seem to be trivial.

I'll look forward to your comments.

Thanks,

Perry

