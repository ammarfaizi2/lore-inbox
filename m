Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbTIOXOk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 19:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261675AbTIOXOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 19:14:40 -0400
Received: from smtp13.eresmas.com ([62.81.235.113]:33952 "EHLO
	smtp13.eresmas.com") by vger.kernel.org with ESMTP id S261368AbTIOXNX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 19:13:23 -0400
Message-ID: <3F664784.8020105@wanadoo.es>
Date: Tue, 16 Sep 2003 01:13:08 +0200
From: Xose Vazquez Perez <xose@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: gl, es, en
MIME-Version: 1.0
CC: Tosatti <marcelo.tosatti@cyclades.com.br>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] changes at SubmittingDrivers v2
References: <3F6646C9.8030808@wanadoo.es>
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------050801060703010408040006"
X-Spam-Score: -2.1
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050801060703010408040006
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Xose Vazquez Perez wrote:

>  Linux 2.2:
> -	If the code area has a general maintainer then please submit it to
> -	the maintainer listed in MAINTAINERS in the kernel file. If the
> -	maintainer does not respond or you cannot find the appropriate
> -	maintainer then please contact Alan Cox <alan@lxorguk.ukuu.org.uk>
> +	The same rules apply as 2.2. The final contact point for submissions
                                ^^^

> +	is Alan Cox <alan@lxorguk.ukuu.org.uk>.

my fault, it must be 2.0.

-- 
Que trabajen los romanos, que tienen el pecho de lata.

--------------050801060703010408040006
Content-Type: text/plain;
 name="SubmittingDrivers.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="SubmittingDrivers.diff"

--- linux/Documentation/SubmittingDrivers	2003-01-16 04:26:18.000000000 +0100
+++ linux.new/Documentation/SubmittingDrivers	2003-09-16 01:04:34.000000000 +0200
@@ -25,21 +25,23 @@
 ------------------------
 
 Linux 2.0:
-	No new drivers are accepted for this kernel tree
+	Only _critical_ and security patches are accepted.
+	No new drivers are accepted for this kernel tree.
 
 Linux 2.2:
-	If the code area has a general maintainer then please submit it to
-	the maintainer listed in MAINTAINERS in the kernel file. If the
-	maintainer does not respond or you cannot find the appropriate
-	maintainer then please contact Alan Cox <alan@lxorguk.ukuu.org.uk>
+	The same rules apply as 2.0. The final contact point for submissions
+	is Alan Cox <alan@lxorguk.ukuu.org.uk>.
 
 Linux 2.4:
-	The same rules apply as 2.2. The final contact point for Linux 2.4 
-	submissions is Marcelo Tosatti <marcelo@conectiva.com.br>.
+	If the code area has a general maintainer then please submit it to
+	the maintainer listed in MAINTAINERS in the kernel file. If the
+	maintainer does not respond or you can not find the appropriate
+	maintainer then please contact Marcelo Tosatti
+	<marcelo.tosatti@cyclades.com.br>.
 
-Linux 2.5:
+Linux 2.6:
 	The same rules apply as 2.4 except that you should follow linux-kernel
-	to track changes in API's. The final contact point for Linux 2.5
+	to track changes in API's. The final contact point for Linux 2.6
 	submissions is Linus Torvalds <torvalds@transmeta.com>.
 
 What Criteria Determine Acceptance

--------------050801060703010408040006--

