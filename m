Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751042AbVKUQq4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbVKUQq4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 11:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751043AbVKUQq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 11:46:56 -0500
Received: from wscnet.wsc.cz ([212.80.64.118]:55680 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S1751041AbVKUQqz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 11:46:55 -0500
Message-ID: <4381F9EB.2070505@gmail.com>
Date: Mon, 21 Nov 2005 17:46:35 +0100
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Rob Landley <rob@landley.net>
CC: Xose Vazquez Perez <xose.vazquez@gmail.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Documentation dir is a mess
References: <438069BD.6000401@gmail.com> <200511211028.28944.rob@landley.net>
In-Reply-To: <200511211028.28944.rob@landley.net>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley napsal(a):

>On Sunday 20 November 2005 06:19, Xose Vazquez Perez wrote:
>  
>
>>hi,
>>
>>_today_ Documentation/* is a mess of files. It would be good
>>to have the _same_ tree as the code has:
>>
>>Documentation/
>>Documentation/arch/
>>Documentation/arch/i386/
>>[...]
>>Documentation/drivers/
>>Documentation/drivers/net/
>>Documentation/drivers/scsi/
>>[...]
>>Documentation/net
>>[...]
>>    
>>
>
>Perhaps you're looking for "make htmldocs"?
>  
>
This is not, what he wants.

>Where would you put Documentation/unicode.txt in your proposed layout?  Or
>  
>
Documentation/others? or sth.

>Documentation/filesystems/proc.txt?
>  
>
It is somewhere, why to move it, simply rename the directory to fs, as
he mentioned.

Sorting is not a problem in my opinion. If no other problem occurs, it
sounds good to me.

regards,

-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E

