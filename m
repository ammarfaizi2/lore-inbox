Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270187AbTGZQ3L (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 12:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270189AbTGZQ3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 12:29:10 -0400
Received: from galaxy.lunarpages.com ([64.235.234.165]:29372 "EHLO
	galaxy.lunarpages.com") by vger.kernel.org with ESMTP
	id S270187AbTGZQ3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 12:29:03 -0400
Message-ID: <3F22B39C.3070200@genebrew.com>
Date: Sat, 26 Jul 2003 13:00:12 -0400
From: Rahul Karnik <rahul@genebrew.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030706
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ed Sweetman <ed.sweetman@wmich.edu>
CC: Eugene Teo <eugene.teo@eugeneteo.net>, LKML <linux-kernel@vger.kernel.org>,
       kernel@kolivas.org
Subject: Re: Ingo Molnar and Con Kolivas 2.6 scheduler patches
References: <1059211833.576.13.camel@teapot.felipe-alfaro.com> <200307261142.43277.m.c.p@wolk-project.de> <3F2251D3.3090107@sambara.org> <20030726101015.GA3922@eugeneteo.net> <3F2264DF.7060306@wmich.edu>
In-Reply-To: <3F2264DF.7060306@wmich.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - galaxy.lunarpages.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - genebrew.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Sweetman wrote:
> 
> I'd really wish people would use examples other than a single player to 
> generalize the performance of the kernel. 

I must wholeheartedly agree. I have not tried any of the interactivity 
work yet, but it is clear that your particular experience will depend on 
the specific test application used. For instance, using net-rhythmbox to 
play mp3s causes skips every time a web page is loaded, but it does not 
happen with xmms. Perhaps we should write down the various interactivity 
tests people have come up with, so that Con/Ingo/whoever else can test 
their work to some extent.

Thanks,
Rahul

