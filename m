Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932324AbVIJViN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932324AbVIJViN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 17:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932326AbVIJViN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 17:38:13 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:51590 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S932324AbVIJViM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 17:38:12 -0400
Message-ID: <4323523A.30901@gmail.com>
Date: Sat, 10 Sep 2005 23:38:02 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 5/10] drivers/char: pci_find_device remove (drivers/char/specialix.c)
References: <200509101221.j8ACL9XI017246@localhost.localdomain> <43234860.7050206@pobox.com> <43234972.3010003@gmail.com> <20050910211711.GA13660@suse.de>
In-Reply-To: <20050910211711.GA13660@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH napsal(a):

>>I won't do that, i did that for 2 drivers and nobody was interested in 
>>that (and its much time left for nothing). These (unrewritten) drivers 
>>would be deleted in some time. Greg wants simply wipe this function out.
>>    
>>
>No, I want it done correctly.  If I simply wanted the function removed,
>I would have done this kind of wholesale conversion a long time ago.
>
>If the code needs to be converted to the proper pci probing logic,
>that's the better way to do it, and that's what should be done.
>  
>
Okay, could you reply the letter i posted a few seconds ago.

thanks,

-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
241B347EC88228DE51EE A49C4A73A25004CB2A10

