Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272974AbRIHGwK>; Sat, 8 Sep 2001 02:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272973AbRIHGwB>; Sat, 8 Sep 2001 02:52:01 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:24336 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S272974AbRIHGvs>; Sat, 8 Sep 2001 02:51:48 -0400
Message-ID: <3B99BCF4.4050506@transmeta.com>
Date: Fri, 07 Sep 2001 23:38:44 -0700
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en, sv
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Hans Lermen <lermen@elserv.ffm.fgan.de>
Subject: LOADLIN and 2.4 kernels
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

I got a bug report of LOADLIN not working with recent -ac kernels, and 
thought it might have something to do with my recent A20 changes that 
were added to -ac.  However, in trying to reproduce this bug, I have 
been completely unable to boot *any* 2.4 kernel with LOADLIN-1.6, trying 
this from Win98 DOS mode.

Anyone have any insight into this?  I really don't understand how the 
A20 changes could affect LOADLIN, and it's starting to look to me that 
there is some other problem going on...

	-hpa

