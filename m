Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262760AbVCDAKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262760AbVCDAKT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 19:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262814AbVCDAI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 19:08:28 -0500
Received: from 200-170-96-180.veloxmail.com.br ([200.170.96.180]:54736 "EHLO
	200-170-96-186.veloxmail.com.br") by vger.kernel.org with ESMTP
	id S262740AbVCCXsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 18:48:41 -0500
X-Authenticated-User: fredlwm@veloxmail.com.br
X-Authenticated-User: fredlwm@veloxmail.com.br
Date: Thu, 3 Mar 2005 20:48:40 -0300 (BRT)
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <2@pervalidus.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: radeonfb blanks my monitor
In-Reply-To: <1109890137.5610.233.camel@gaston>
Message-ID: <Pine.LNX.4.62.0503032044350.416@darkstar.example.net>
References: <Pine.LNX.4.62.0503022347070.311@darkstar.example.net> 
 <1109823010.5610.161.camel@gaston>  <Pine.LNX.4.62.0503030134200.311@darkstar.example.net>
  <1109825452.5611.163.camel@gaston>  <Pine.LNX.4.62.0503031149280.311@darkstar.example.net>
 <1109890137.5610.233.camel@gaston>
X-Archive: encrypt
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-115376323-1109893720=:416"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-115376323-1109893720=:416
Content-Type: TEXT/PLAIN; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 4 Mar 2005, Benjamin Herrenschmidt wrote:

> On Thu, 2005-03-03 at 12:38 -0300, Fr=E9d=E9ric L. W. Meunier wrote:
>=20
> Maybe we are having conflicting bus names between radeonfb=20
> and matroxfb, or 2 instances of radeonfb ? Can you send the=20
> entire log please ?

I don't have matroxfb and there aren't 2 instances of radeonfb.

>> There's nothing about radeonfb in dmesg because I manually
>> loaded the modules.
>
> And ? You should have it in dmesg after the module load...

Not in /var/log/dmesg, and I can't type dmesg.

> Well, I would need the full log, and with radeonfb verbose=20
> debug enabled in the config.

I'll later try as module with debug.

--=20
How to contact me - http://www.pervalidus.net/contact.html
--8323328-115376323-1109893720=:416--
