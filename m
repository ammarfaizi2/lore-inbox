Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261594AbSJFMeq>; Sun, 6 Oct 2002 08:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261598AbSJFMeq>; Sun, 6 Oct 2002 08:34:46 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:39555 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S261594AbSJFMeo>;
	Sun, 6 Oct 2002 08:34:44 -0400
Message-ID: <3DA02F30.8040904@colorfullife.com>
Date: Sun, 06 Oct 2002 14:40:16 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 4.0)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re:  BK MetaData License Problem?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>                              By transmitting the Metadata
>      to an Open Logging server, You hereby grant BitMover,
>      or any other operator of an Open Logging server, per-
>      mission  to  republish  the Metadata sent by the Bit-
>      Keeper Software to the Open Logging server.
> 

Where is the problem? This asks for a permission, not for exclusive rights.


> 	By transmitting the MetaData to an Open Logging server, You 
>         hereby also agree to license the MetaData under the same license
>         you license the data it describes.
> 
> (or something to that extent - i'm not a lawyer.)
> 

That's a problem for Linux, not for Larry.

If you send a patch to Linus this means you distribute a modification to 
GPLed source, which means it's automatically placed under the GPL.

What's missing is a comment in the BK-usage document that informs the 
submitter that he must give the permission to republish the commit info. 
i.e. asking Linus to pull from an url is not a private message to Linus, 
it's the equivalent of sending a mail to a public, moderated mailing list.

--
	Manfred

