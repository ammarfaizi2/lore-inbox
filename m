Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264319AbTH1TcZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 15:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264318AbTH1TcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 15:32:25 -0400
Received: from smtp100.mail.sc5.yahoo.com ([216.136.174.138]:8025 "HELO
	smtp100.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264319AbTH1TcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 15:32:20 -0400
Date: Thu, 28 Aug 2003 16:30:24 -0300
From: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
To: Yokota Hiroshi <yokota@netlab.is.tsukuba.ac.jp>
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: [PATCH][resend] 6/13 2.4.22-rc2 fix __FUNCTION__ warnings
 drivers/scsi/pcmcia
Message-Id: <20030828163024.705a56ea.vmlinuz386@yahoo.com.ar>
In-Reply-To: <20030824041845U.yokota@netlab.is.tsukuba.ac.jp>
References: <20030822041522.0daf7ff6.vmlinuz386@yahoo.com.ar>
	<20030824041845U.yokota@netlab.is.tsukuba.ac.jp>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i486-slackware-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Aug 2003 04:18:45 +0900, Yokota Hiroshi wrote:
> Hello, Gerardo.
>
> Thanks for your patch. This probrem is fixed on Kernel 2.6.0-test4.
>And you can get independent source code from
>http://www.netlab.is.tsukuba.ac.jp/~yokota/izumi/ninja/
>
>

Yes, but you can resend/confirm this fixes to Marcelo to apply it in 2.4.23-preX ?

Thanks in advance.

>
>From: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
>Subject: [PATCH][resend] 6/13 2.4.22-rc2 fix __FUNCTION__ warnings drivers/scsi/pcmcia
>Date: Fri, 22 Aug 2003 04:15:22 -0300
>
>> Hi people,
>> this patch fix the warning: concatenation of string literals with __FUNCTION__ is deprecated
>


chau,
 djgera


-- 
Gerardo Exequiel Pozzi ( djgera )
http://www.vmlinuz.com.ar http://www.djgera.com.ar
KeyID: 0x1B8C330D
Key fingerprint = 0CAA D5D4 CD85 4434 A219  76ED 39AB 221B 1B8C 330D
