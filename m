Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263472AbUEGJub@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263472AbUEGJub (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 05:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263394AbUEGJub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 05:50:31 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:63759 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S263472AbUEGJtA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 05:49:00 -0400
Message-ID: <409B5BF0.6070609@aitel.hist.no>
Date: Fri, 07 May 2004 11:50:40 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-rc3-mm2 (4KSTACK)
References: <20040505013135.7689e38d.akpm@osdl.org> <200405051312.30626.dominik.karall@gmx.net> <200405051822.i45IM2uT018573@turing-police.cc.vt.edu> <20040505215136.GA8070@wohnheim.fh-wedel.de> <200405061518.i46FIAY2016476@turing-police.cc.vt.edu>            <1083858033.3844.6.camel@laptop.fenrus.com> <200405061629.i46GTm2x018759@turing-police.cc.vt.edu>
In-Reply-To: <200405061629.i46GTm2x018759@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:

>On Thu, 06 May 2004 17:40:33 +0200, Arjan van de Ven said:
>  
>
>>Ok I don't want to start a flamewar but... Do we want to hold linux back
>>until all binary only module vendors have caught up ??
>>    
>>
>
>No.. I merely suggested that coordinating with as few as possibly one vendor to
>clean their module up might minimize the pain considerably.  
>

I don't see much of a problem.  So what if Linus puts 4k stacks in 2.6.6 
tomorrow?
It won't kill linux for all those nvidia users.  They'll simply have to 
stop at 2.6.5
until nvidia catch up.  Not much of a problem, considering how the majority
still runs various versions of 2.4.x.

Helge Hafting
