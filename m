Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261202AbVAGAvw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbVAGAvw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 19:51:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261155AbVAGAuB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 19:50:01 -0500
Received: from mailer2-5.key-systems.net ([81.3.43.243]:24552 "HELO
	mailer2-1.key-systems.net") by vger.kernel.org with SMTP
	id S261190AbVAGAre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 19:47:34 -0500
Message-ID: <41DDDC22.80009@mathematica.scientia.net>
Date: Fri, 07 Jan 2005 01:47:30 +0100
From: Christoph Anton Mitterer <cam@mathematica.scientia.net>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Questions about the CMD640 and RZ1000 bugfix support options
References: <41D5D206.1040107@mathematica.scientia.net>	 <1104676209.15004.58.camel@localhost.localdomain>	 <e0qta2-7jr.ln1@kenga.kmv.ru>	 <1105025417.17176.222.camel@localhost.localdomain>	 <hcr0b2-ofr.ln1@kenga.kmv.ru>  <41DDC55B.2030106@mathematica.scientia.net> <1105053558.17176.297.camel@localhost.localdomain>
In-Reply-To: <1105053558.17176.297.camel@localhost.localdomain>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

 >On Iau, 2005-01-06 at 23:10, Christoph Anton Mitterer wrote:
 >
 >>What about the following idea?
 >>Both stay enabled by default but the help text explains exactly (as
 >>far as possible) which systems are affected.
 >>This would help newbies like me to decide if those bugfixes are
 >>necessary or not.
 >
 >
 >Its the ideal solution. The diff for this is available on your computer
 >already - its kept in /dev/null 8)

Ok,... so here's my patch which I request for inclusion:
--- begin of patch ---

--- end of patch ---
(Ahh,.. my first kernel patch,... *lol* )

;-)


Seriously,.. I thought about adding something like:
"Most users of modern computers won't need this, but it is safer to say 
Y here."

But according to you answer I think that you like the way it's at the 
moment. =)
Never mind! But if you think it's ok I could make a (real) patch which 
adds such a text.

Best wishes,
cam.
