Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262727AbVCXJN6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262727AbVCXJN6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 04:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263077AbVCXJN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 04:13:58 -0500
Received: from outmail1.freedom2surf.net ([194.106.33.237]:16554 "EHLO
	outmail.freedom2surf.net") by vger.kernel.org with ESMTP
	id S262727AbVCXJNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 04:13:55 -0500
Message-ID: <4242865D.90800@qazi.f2s.com>
Date: Thu, 24 Mar 2005 09:20:29 +0000
From: Asfand Yar Qazi <ay1204@qazi.f2s.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041010
X-Accept-Language: en-gb, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: How's the nforce4 support in Linux?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm currently contemplating going for an Athlon 64 system.  However, 
I'll primarily be using a Linux-based OS (Gentoo, namely), so I need 
to know how well the chipsets are supported currently.

I'd really like to go Via - but the crummy KT890 / VT8237 combo sucks 
- mainly due to the lack of SATA II with NCQ.  I share the sentiments 
of the person in a post in the AnandTech forums 
(http://tinyurl.com/6d9bx) who says:

"The feature set on the K8T890 sucks. It was supposed to use the 
VT8251 southbridge, bringing SATA-II/NCQ, HD Audio, etc. 
Unfortunately, this southbridge has since dissappeared off the face of 
the earth, and all the current K8T890 boards use the old VT8237. 
nForce4, on the other hand, has SATA-II/NCQ, hardware firewall, nice 
software overclocking/monitoring tools (ntune), gigabit lan, etc. On 
top of that, performance and overclocking is pretty damn good. I was 
at one point looking forward to the K8T890, but considering how much 
of a joke the whole product line has been (lacking features, months of 
delays with no explanation, lack of any variety of retail boards), I 
have to say I'd avoid it like the plague."

NForce4 Ultra is brilliant - in many ways.  Except it requires binary 
drivers, which I really don't want to use.  And apparently, the 
hardware firewall seems to restrict bandwidth a bit.  And even when 
its off, external chips that end up being faster 
(http://tinyurl.com/4zssp)

So, I'm wondering, are my assumptions correct?  Do I have to use 
binary drivers to make absolutely full use of the Nforce4 chipset?  Or 
is there sufficient support for me to make use of the features on it 
without using binary drivers?

Sorry for asking something that may have been asked before, but I've 
tried searching several times through the mailing list and on a search 
engine, but have had little luck.

Thanks,
	Asfand Yar

p.s. Here's something for the search engines to latch on to, so this 
post and any repies are easier to find: via nvidia nforce4 nforce 4 
kt890 kt 890 vt8237 comparison feature set supported compatibility 
binary drivers
