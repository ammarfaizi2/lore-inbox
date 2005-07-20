Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261183AbVGTMNJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbVGTMNJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 08:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbVGTMNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 08:13:09 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:44679 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261183AbVGTMNH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 08:13:07 -0400
Message-ID: <42DE3FC0.8070500@gmail.com>
Date: Wed, 20 Jul 2005 14:12:48 +0200
From: Jiri Slaby <lnx4us@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Remove Comtrol mail address from MAINTAINERS
References: <200507200932.35003@bilbo.math.uni-mannheim.de>
In-Reply-To: <200507200932.35003@bilbo.math.uni-mannheim.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rolf Eike Beer napsal(a):

>Every Mail to this address produces a mail telling that they do no longer 
>monitor this address and you should use their webinterface.
>
>"We are pleased to offer this powerful replacement to standard email support."
>
>Some people just don't understand.
>
>Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>
>
>--- linux-2.6.13-rc3/MAINTAINERS	2005-07-20 09:05:30.000000000 +0200
>+++ linux-2.6.13-rc3-eike/MAINTAINERS	2005-07-20 09:13:40.000000000 +0200
>@@ -1934,7 +1934,6 @@
> 
> ROCKETPORT DRIVER
> P:	Comtrol Corp.
>-M:	support@comtrol.com
> W:	http://www.comtrol.com
> S:	Maintained
>  
>
And you can remove these:
... while talking to advansys.com <http://advansys.com>.:
 >>> DATA
<<< 550 5.7.1 <linux@advansys.com <mailto:linux@advansys.com>>... 
Relaying denied. Proper authentication required.
550 5.1.1 <linux@advansys.com <mailto:linux@advansys.com>>... User unknown
<<< 503 5.0.0 Need RCPT (recipient)
... while talking to ali.ali.com.tw <http://ali.ali.com.tw>.:
 >>> RCPT To:<cjtsai@ali.com.tw <mailto:cjtsai@ali.com.tw>>
<<< 550 unknown user.
550 5.1.1 <cjtsai@ali.com.tw <mailto:cjtsai@ali.com.tw>>... User unknown

