Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317006AbSFFQlF>; Thu, 6 Jun 2002 12:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317007AbSFFQlE>; Thu, 6 Jun 2002 12:41:04 -0400
Received: from host133-176-65-207.ezsweeps.com ([207.65.176.133]:10381 "EHLO
	destiney.com") by vger.kernel.org with ESMTP id <S317006AbSFFQlE>;
	Thu, 6 Jun 2002 12:41:04 -0400
Date: Thu, 6 Jun 2002 11:42:08 -0500 (CDT)
From: Greg Donald <greg@destiney.com>
To: linux-kernel@vger.kernel.org
Subject: list serv help
Message-ID: <Pine.LNX.4.44.0206061121020.23180-100000@destiney.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


My server lost dns for several hours a couple of weeks back.  Since then 
I have made several unsuccessful attempts at getting back on the 
linux-kernel list serv.  As far as I can tell I was unsubscribed durign 
my dns outage.

I started reading the available FAQs and came across the MX record 
verfication form at http://vger.kernel.org/mxverify.html:

The results seem incorrect: 
http://vger.kernel.org/cgi-bin/mxverify-cgi?DOMAIN=greg@destiney.com&SUBMIT=Submit+to+VGER.KERNEL.ORG

Testing MX server: mail.destiney.com

--- sorry, address lookup for ``mail.destiney.com'' failed;
code = Temporary failure in name resolution


But when I try my domain from any other server I have no issues:

firewall:~$ nslookup mail.destiney.com
Server:  sun00bna.bna.bellsouth.net
Address:  205.152.150.254

Non-authoritative answer:
Name:    destiney.com
Address:  207.65.176.133
Aliases:  mail.destiney.com


+-(destiney@gateway)
+-(~)> nslookup mail.destiney.com
Server:         68.52.0.5
Address:        68.52.0.5#53

Non-authoritative answer:
mail.destiney.com       canonical name = destiney.com.
Name:   destiney.com
Address: 207.65.176.133


Can anyone help me to get back subscribed to linux-kernel?

Thanks in advance.

-- 
-----------------------------------------------------------------------
Greg Donald
http://destiney.com/public.key
-----------------------------------------------------------------------

