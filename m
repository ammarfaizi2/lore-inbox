Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262779AbVA1TYe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262779AbVA1TYe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 14:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262697AbVA1TV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 14:21:58 -0500
Received: from smtp8.poczta.onet.pl ([213.180.130.48]:24478 "EHLO
	smtp8.poczta.onet.pl") by vger.kernel.org with ESMTP
	id S262791AbVA1TSd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 14:18:33 -0500
Message-ID: <41FA90F8.6060302@poczta.onet.pl>
Date: Fri, 28 Jan 2005 20:22:32 +0100
From: Wiktor <victorjan@poczta.onet.pl>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dtor_core@ameritech.net
CC: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: AT keyboard dead on 2.6
References: <41F11F79.3070509@poczta.onet.pl>	 <d120d500050121074831087013@mail.gmail.com>	 <41F15307.4030009@poczta.onet.pl>	 <d120d500050121113867c82596@mail.gmail.com>	 <41F69FFE.2050808@poczta.onet.pl> <20050128143121.GB12137@ucw.cz> <d120d50005012806467cc5ee03@mail.gmail.com>
In-Reply-To: <d120d50005012806467cc5ee03@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------040307030505010707070706"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040307030505010707070706
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

>This dmesg looks like the keyboard works perfectly OK. Do new lines
>appear in dmesg when you press keys while the system is running?

eeeeeeee.....no? no, they don't. i've new dmesg for you - it reports 
timeouts while trying to perform keyboard reset (by atkbd.reset=1). 
after detection pressing any keys has absolutley no effect. maybe it's 
some timeout-violation?

---
May the Source be with you.
wixor (it's my nick)

--------------040307030505010707070706
Content-Type: application/gzip;
 name="dmesg-2.6.8.1.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="dmesg-2.6.8.1.gz"

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
uFUctpuSpHtPoYdx6JnJ0D/G/w+mkQsJ1hwAAA==
--------------040307030505010707070706--
