Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261293AbTINTC0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 15:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbTINTCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 15:02:19 -0400
Received: from smtp6.wanadoo.fr ([193.252.22.28]:25606 "EHLO
	mwinf0303.wanadoo.fr") by vger.kernel.org with ESMTP
	id S261290AbTINTCN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 15:02:13 -0400
Message-ID: <3F64BC4D.9020102@wanadoo.fr>
Date: Sun, 14 Sep 2003 21:06:53 +0200
From: =?ISO-8859-1?Q?R=E9mi_Colinet?= <remi.colinet@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Breno <brenosp@brasilsec.com.br>
Cc: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 1:1 M:N threading
References: <000b01c37af0$402349a0$f8e4a7c8@bsb.virtua.com.br>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Breno wrote:

>Hi.
>
>What kind of threading kernel 2.4 and 2.6 do ? 1:1 or M:N ?
>
>
>thanks
>Breno
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
Hello,

For 2.6, the default is NGPT (see 
http://www-124.ibm.com/developerworks/oss/pthreads/) which is 1:1.

Regards
Rémi


