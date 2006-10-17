Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423133AbWJQGRS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423133AbWJQGRS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 02:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423135AbWJQGRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 02:17:18 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:21682 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1423133AbWJQGRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 02:17:17 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <4534755B.2000804@s5r6.in-berlin.de>
Date: Tue, 17 Oct 2006 08:16:59 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Gene Heskett <gene.heskett@verizon.net>
CC: For users of Fedora Core releases <fedora-list@redhat.com>,
       linux-kernel@vger.kernel.org, linux1394-user@lists.sourceforge.net
Subject: Re: raw1394 problems galore FIXED!!!!!
References: <4532DF11.9060704@verizon.net> <4533B889.5060302@s5r6.in-berlin.de> <4533DDA2.2050008@verizon.net> <4533FBD8.7050101@s5r6.in-berlin.de> <45342789.2050506@verizon.net> <453440C7.2060800@verizon.net>
In-Reply-To: <453440C7.2060800@verizon.net>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:
..
> Tonight, I saw that kernel-2.6.18-1.2200.fc5.i686 was available, along
> with the matching kmod-ndiswrapper pieces and kmod-ntfs in versions
> 2.6.18-1.2200.fc5 were available, so I installed them and rebooted.
> 
> Now kino-0.8 works sortof, wants to crash.
> And kino-0.9.2 apparently works flawlessly, as does dvcont.
...
> So it was a kernel problem all along!
...

I have no idea what we did between 2.6.17 and .18 that made it work. Or
was it just the reboot after kernel update which brought it into shape?
-- 
Stefan Richter
-=====-=-==- =-=- =---=
http://arcgraph.de/sr/
