Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751487AbVJLSO0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487AbVJLSO0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 14:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbVJLSO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 14:14:26 -0400
Received: from kirby.webscope.com ([204.141.84.57]:48848 "EHLO
	kirby.webscope.com") by vger.kernel.org with ESMTP id S1751487AbVJLSO0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 14:14:26 -0400
Message-ID: <434D5269.8000708@m1k.net>
Date: Wed, 12 Oct 2005 14:14:01 -0400
From: Michael Krufky <mkrufky@m1k.net>
Reply-To: mkrufky@m1k.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jiri Slaby <xslaby@fi.muni.cz>
CC: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.14-rc4] Maintainers one entry removed
References: <4af2d03a0510061516t32a62180t380dcb856d45a774@mail.gmail.com> <20051012170612.619C422AF21@anxur.fi.muni.cz>
In-Reply-To: <20051012170612.619C422AF21@anxur.fi.muni.cz>
Content-Type: multipart/mixed;
 boundary="------------050602000003080700000204"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050602000003080700000204
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jiri Slaby wrote:

>Maintainers one entry removed
>
>Computone intelliport multiport card is no longer maintained. The
>maintainer doesn't respond to e-mails (3 times during 1 month). The page was
>updated 2 years ago and there is no other contact.
>
>Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>
>
Rather than removing the entry entirely, wouldn't something like this be 
more appropriate?

Signed-off-by: Michael Krufky <mkrufky@m1k.net>



--------------050602000003080700000204
Content-Type: text/plain;
 name="maintainer.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="maintainer.patch"

diff -up a/MAINTAINERS b/MAINTAINERS
--- a/MAINTAINERS	2005-10-12 14:02:10.267405404 -0400
+++ b/MAINTAINERS	2005-10-12 14:09:48.621252057 -0400
@@ -581,10 +581,7 @@ L:	pcihpd-discuss@lists.sourceforge.net
 S:	Supported
 
 COMPUTONE INTELLIPORT MULTIPORT CARD
-P:	Michael H. Warfield
-M:	mhw@wittsend.com
-W:	http://www.wittsend.com/computone.html
-S:	Maintained
+S:	Orphaned
 
 COSA/SRP SYNC SERIAL DRIVER
 P:	Jan "Yenya" Kasprzak

--------------050602000003080700000204--

