Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264519AbUEDRVb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264519AbUEDRVb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 13:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264528AbUEDRVb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 13:21:31 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:10501 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S264519AbUEDRV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 13:21:29 -0400
Message-ID: <4097D278.9030701@techsource.com>
Date: Tue, 04 May 2004 13:27:20 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: David Lang <david.lang@digitalinsight.com>
CC: Giuliano Colla <copeca@copeca.dsnet.it>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>,
       Linus Torvalds <torvalds@osdl.org>, hsflinux@lists.mbsi.ca,
       Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [hsflinux] [PATCH] Blacklist binary-only modules lying about
 their license
References: <408DC0E0.7090500@gmx.net> <40914C35.1030802@copeca.dsnet.it> <Pine.LNX.4.58.0404291404100.1629@ppc970.osdl.org> <409256A4.5080607@copeca.dsnet.it> <409276D6.9070500@gmx.net> <4092A88D.70007@copeca.dsnet.it> <Pine.GSO.4.58.0405021030410.7925@waterleaf.sonytel.be> <40957585.5060105@copeca.dsnet.it> <Pine.LNX.4.58.0405021819220.28837@dlang.diginsite.com>
In-Reply-To: <Pine.LNX.4.58.0405021819220.28837@dlang.diginsite.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



David Lang wrote:
> except that this brings up the issue of if the GPL will allow this
> linking to take place at all.
> 
> my understanding of what RMS and the FSF have said is that they don't
> believe that this is allowed at all.
> 


It's allowed if the code under GPL was written by Marc and he licenses 
it as such, such as "it's my license, unless you copy it, then it's GPL."

