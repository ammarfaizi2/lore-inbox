Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964847AbWIVSJz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964847AbWIVSJz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 14:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964848AbWIVSJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 14:09:55 -0400
Received: from terminus.zytor.com ([192.83.249.54]:34478 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S964847AbWIVSJy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 14:09:54 -0400
Message-ID: <451426C9.9040002@zytor.com>
Date: Fri, 22 Sep 2006 11:09:13 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Johannes Stezenbach <js@linuxtv.org>
CC: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       Dax Kelson <dax@gurulabs.com>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Smaller compressed kernel source tarballs?
References: <1158870777.24172.23.camel@mentorng.gurulabs.com> <20060921204250.GN13641@csclub.uwaterloo.ca> <45130792.9040104@zytor.com> <20060922140007.GK13639@csclub.uwaterloo.ca> <Pine.LNX.4.61.0609221811560.12304@yvahk01.tjqt.qr> <4514103D.8010303@zytor.com> <20060922174137.GA29929@linuxtv.org>
In-Reply-To: <20060922174137.GA29929@linuxtv.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Stezenbach wrote:
> 
> It seems the "lzma" program from LZMA Utils can:
> 
> http://tukaani.org/lzma/
>   "Very similar command line interface than what gzip and bzip2 have."
> 
> (Debian sid has this in the "lzma" package.)
> 

Yes, it can.  If that's the way things go then I don't mind it, however, 
my biggest problem with lzma utils is that the command line parsing is 
done in a shell script wrapper.

Maybe I'll start using it anyway...

	-hpa

