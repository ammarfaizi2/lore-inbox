Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261391AbVDMQru@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261391AbVDMQru (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 12:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261394AbVDMQru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 12:47:50 -0400
Received: from terminus.zytor.com ([209.128.68.124]:61641 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261391AbVDMQrq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 12:47:46 -0400
Message-ID: <425D4D40.3040106@zytor.com>
Date: Wed, 13 Apr 2005 09:48:00 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Xavier Bestel <xavier.bestel@free.fr>
CC: David Woodhouse <dwmw2@infradead.org>, Petr Baudis <pasky@ucw.cz>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] git-pasky-0.3
References: <20050409200709.GC3451@pasky.ji.cz>	 <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org>	 <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org>	 <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org>	 <20050410024157.GE3451@pasky.ji.cz> <20050410162723.GC26537@pasky.ji.cz>	 <20050411015852.GI5902@pasky.ji.cz> <20050411135758.GA3524@pasky.ji.cz>	 <1113311256.20848.47.camel@hades.cambridge.redhat.com>	 <20050413094705.B1798@flint.arm.linux.org.uk>	 <20050413085954.GA13251@pasky.ji.cz>	 <1113384304.12012.166.camel@baythorne.infradead.org> <1113396229.17538.134.camel@gonzales>
In-Reply-To: <1113396229.17538.134.camel@gonzales>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Xavier Bestel wrote:
> Le mercredi 13 avril 2005 à 10:25 +0100, David Woodhouse a écrit :
> 
>>On Wed, 2005-04-13 at 10:59 +0200, Petr Baudis wrote:
>>
>>>Theoretically, you are never supposed to share your index if you work
>>>in fully git environment. 
>>
>>Maybe -- if we are prepared to propagate the BK myth that network
>>bandwidth and disk space are free. 
> 
> 
> On a related note, maybe kernel.org should host .torrent files (and
> serve them) for the kernel git repository. That would ease the pain.
> 

/me inflicts major bodily harm on Xav.

There is a reason we (kernel.org) doesn't touch Bittorrent: for a 
variety of reasons, Bittorrent doesn't lend itself very well to 
automation.  Jeff Garzik and I have been sketching on a sane replacement 
for Bittorrent with the working name "Software Distribution Protocol", 
but it's not even vaporware so far.

	-hpa
