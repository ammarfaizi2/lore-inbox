Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262913AbVCDRRd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262913AbVCDRRd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 12:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262614AbVCDRRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 12:17:32 -0500
Received: from 200-170-96-180.veloxmail.com.br ([200.170.96.180]:54647 "HELO
	qmail-out.veloxmail.com.br") by vger.kernel.org with SMTP
	id S262913AbVCDRQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 12:16:16 -0500
X-qfilter-stat: ok
Date: Fri, 4 Mar 2005 14:16:14 -0300 (BRT)
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <2@pervalidus.net>
To: Jean Delvare <khali@linux-fr.org>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: radeonfb blanks my monitor
In-Reply-To: <42283AE5.9030700@linux-fr.org>
Message-ID: <Pine.LNX.4.62.0503041415050.163@darkstar.example.net>
References: <Pine.LNX.4.62.0503022347070.311@darkstar.example.net>  <1109823010.5610.161.camel@gaston> 
	<Pine.LNX.4.62.0503030134200.311@darkstar.example.net> <1109825452.5611.163.camel@gaston>
	<Pine.LNX.4.62.0503031149280.311@darkstar.example.net> <42283AE5.9030700@linux-fr.org>
X-Archive: encrypt
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1212385995-1109956574=:163"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1212385995-1109956574=:163
Content-Type: TEXT/PLAIN; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 4 Mar 2005, Jean Delvare wrote:

> Fr=E9d=E9ric, can you check in /etc/modprobe.conf if you have a=20
> line like: options i2c-algo-bit bit_test=3D1 If you do, please=20
> comment it out and see if it changes anything.

Yes, I had, but commenting it out didn't change anything.

--=20
How to contact me - http://www.pervalidus.net/contact.html

--8323328-1212385995-1109956574=:163--
