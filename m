Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269342AbUICIG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269342AbUICIG4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 04:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269368AbUICIDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 04:03:20 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:63750 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S269374AbUICICn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 04:02:43 -0400
Message-ID: <41382624.7000701@hist.no>
Date: Fri, 03 Sep 2004 10:07:00 +0200
From: Helge Hafting <helge.hafting@hist.no>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040830)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tom Vier <tmv@comcast.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: silent semantic changes with reiser4
References: <Pine.LNX.4.58.0408251555070.17766@ppc970.osdl.org> <1453698131.20040826011935@tnonline.net> <20040825163225.4441cfdd.akpm@osdl.org> <20040825233739.GP10907@legion.cup.hp.com> <20040825234629.GF2612@wiggy.net> <1093480940.2748.35.camel@entropy> <20040826044425.GL5414@waste.org> <1093496948.2748.69.camel@entropy> <20040826053200.GU31237@waste.org> <412D9FFA.6030307@hist.no> <20040902230526.GB15505@zero>
In-Reply-To: <20040902230526.GB15505@zero>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Vier wrote:

>What's wrong with ~/.thumbcache or a daemon that manages system wide cache?
>
>  
>
Moving a file doen't move the associated thumbnail, and then you
notice something is missing, or don't find the file, or have to wait
for regeneration when the app notices a file without a tumb. 
That could take some time if you moved a directory full of postscript
files, for example.

Helge Hafting
