Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422681AbWJFNzx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422681AbWJFNzx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 09:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422682AbWJFNzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 09:55:53 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:13531 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1422681AbWJFNzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 09:55:52 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <45266042.4060107@s5r6.in-berlin.de>
Date: Fri, 06 Oct 2006 15:55:14 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
CC: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bcollins@debian.org, linux1394-devel@lists.sourceforge.net
Subject: Re: ohci1394 regression in 2.6.19-rc1
References: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org> <200610052132.11544.s0348365@sms.ed.ac.uk> <4525842F.3040109@s5r6.in-berlin.de> <200610052337.17805.s0348365@sms.ed.ac.uk> <452593AC.3000406@s5r6.in-berlin.de>
In-Reply-To: <452593AC.3000406@s5r6.in-berlin.de>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:
> One more thing you could to try if you can spare the time:
> 
> Build and boot Linux _2.6.18_ after applying this patchkit:

Not necessary anymore.

I saw the messages and the delay that you described now too, using Linux
2.6.18 + all IEEE 1394 updates. I will continue to narrow the cause down.

Thanks,
-- 
Stefan Richter
-=====-=-==- =-=- --==-
http://arcgraph.de/sr/
