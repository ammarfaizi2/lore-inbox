Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261546AbVA2UZY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261546AbVA2UZY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 15:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261549AbVA2UZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 15:25:24 -0500
Received: from smtp7.poczta.onet.pl ([213.180.130.47]:59082 "EHLO
	smtp7.poczta.onet.pl") by vger.kernel.org with ESMTP
	id S261546AbVA2UZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 15:25:10 -0500
Message-ID: <41FBF221.6050800@poczta.onet.pl>
Date: Sat, 29 Jan 2005 21:29:21 +0100
From: Wiktor <victorjan@poczta.onet.pl>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: dtor_core@ameritech.net, linux-kernel@vger.kernel.org
Subject: Re: AT keyboard dead on 2.6
References: <41F11F79.3070509@poczta.onet.pl> <d120d500050121074831087013@mail.gmail.com> <41F15307.4030009@poczta.onet.pl> <d120d500050121113867c82596@mail.gmail.com> <41F69FFE.2050808@poczta.onet.pl> <20050128143121.GB12137@ucw.cz> <d120d50005012806467cc5ee03@mail.gmail.com> <41FA90F8.6060302@poczta.onet.pl> <20050128192732.GA2799@ucw.cz>
In-Reply-To: <20050128192732.GA2799@ucw.cz>
Content-Type: multipart/mixed;
 boundary="------------030903090504060904020108"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030903090504060904020108
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

> It still looks OK. It seems to be a very ancient keyboard. Can you try with
> a newer one? That'd tell us whether it's the controller or the keyboard
> that is giving problems.
> 
> What keyboard model is it? What machine?
> 

Machine info attached as a part of /dev/proc. i've tried with another AT 
keyboard and PS/2 keyboard attached via connector - results were the 
same. keyboard i'm using is: chicony model KB-5911 serial 6A00152705. 
what does it mean 'ancient'? mine keyb has about 10 years. is it ancient 
or not (it is the first keyboard i've been using)?

--
May the Source be with you.
wixor

--------------030903090504060904020108
Content-Type: application/octet-stream;
 name="sysinfo.tar.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="sysinfo.tar.bz2"

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
wEHTYzyoEaEfGxIXzMP/F3JFOFCQWr9Gvg==
--------------030903090504060904020108--
