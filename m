Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314596AbSGYQAE>; Thu, 25 Jul 2002 12:00:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314811AbSGYQAE>; Thu, 25 Jul 2002 12:00:04 -0400
Received: from 212.Red-80-35-44.pooles.rima-tde.net ([80.35.44.212]:3712 "EHLO
	DervishD.pleyades.net") by vger.kernel.org with ESMTP
	id <S314596AbSGYQAE>; Thu, 25 Jul 2002 12:00:04 -0400
Date: Thu, 25 Jul 2002 18:09:37 +0200
Organization: Pleyades
To: bhards@bigpond.net.au, linux-kernel@vger.kernel.org, hpa@zytor.com
Subject: Re: Header files and the kernel ABI
Message-ID: <3D4022C1.mail9Z311T4P@viadomus.com>
References: <aho5ql$9ja$1@cesium.transmeta.com>
 <200207252308.00656.bhards@bigpond.net.au>
In-Reply-To: <200207252308.00656.bhards@bigpond.net.au>
User-Agent: nail 9.31 6/18/02
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
From: DervishD <raul@pleyades.net>
Reply-To: DervishD <raul@pleyades.net>
X-Mailer: DervishD TWiSTiNG Mailer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Brad & HPA :)

>> already-established __kernel_ namespace, and of course __s* and __u*
>> could be used for specific types.
>I like it (having just argued for it), except for the __s* and __u*.
[...]
>Please, let us agree that the ABI definition should use standard
>types wherever possible.

    I think so. Moreover, any user-space developer should be familiar
with them and anyone may even use the standard ones by mistake, so
it's better to get them equal and be standard.

    Raúl
