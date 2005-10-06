Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751359AbVJFVZI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbVJFVZI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 17:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbVJFVZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 17:25:07 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:32642 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S1751359AbVJFVZG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 17:25:06 -0400
Message-ID: <4345962C.4080305@gmail.com>
Date: Thu, 06 Oct 2005 23:25:00 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: umesh chandak <chandak_pict@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: about FC3 2.6.10 ..........
References: <20051006185922.81946.qmail@web35912.mail.mud.yahoo.com> <200510061925.j96JPWdA027095@turing-police.cc.vt.edu>
In-Reply-To: <200510061925.j96JPWdA027095@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu napsal(a):

>On Thu, 06 Oct 2005 11:59:22 PDT, umesh chandak said:
>  
>
>>Hi,
>>             I have compiled a 2.6.10 on FC3.It
>>compiled successfully .But When i boot to this option
>>,it gives me warning 
>>        Warning: unable to open an initial console
>>I know this is due to something genromfs . I also read
>>about romfs in documentation .
>>    
>>
>
>(Not a kernel question - next time, ask on one of the Fedora lists at redhat.com)
>
>Getting FC3 to run on on a romfs based system will be a challenge.  In any
>case, romfs has approximately zero to do with your problem.
>
>What you've almost certainly done is forgotten to do a proper 'mkinitrd' -
>FC3 and later need an initrd to get going in most cases.  (Specifically,
>your initrd image needs to have a /dev/console entry in the /dev on the
>  
>
Yes, but I really don't know how many times we should tell him this,
unless he understands it, grr.
[Your post is at least the third reply to this question :(].

-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
241B347EC88228DE51EE A49C4A73A25004CB2A10

