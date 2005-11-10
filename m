Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750872AbVKJO1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750872AbVKJO1U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 09:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750951AbVKJO1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 09:27:20 -0500
Received: from xproxy.gmail.com ([66.249.82.199]:47926 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750841AbVKJO1T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 09:27:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:openpgp:content-type:content-transfer-encoding;
        b=WsJIbmeIvcusmGBlzZ2yrdyqyIfEzOleYnEkXzoefC4oSN2b8jq0vFgIn+EIzmUnISYHt9gDoA3P+SgJ77pXTQMosXXIPC0sAzYK23yhB+KeLx4GlDX9ytliuyiPpxvED5hOlS2cvmiLNp2C0wojeMSI4Raf7mGy7IVGk7Mu9Jk=
Message-ID: <437358C3.6070301@gmail.com>
Date: Thu, 10 Nov 2005 16:27:15 +0200
From: Matan Peled <chaosite@gmail.com>
Reply-To: chaosite@gmail.com
Organization: Chaosite Destruction, inc.
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20051014 Thunderbird/1.0.7 Mnenhy/0.7.2.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alejandro Bonilla Beeche <abonilla@linuxwireless.org>
CC: Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Kernel Panic 2.6.14-git
References: <43727E72.4040103@linuxwireless.org> <9a8748490511091500h4363308fm42312354e3fde8ab@mail.gmail.com> <43728A6D.5080908@linuxwireless.org>
In-Reply-To: <43728A6D.5080908@linuxwireless.org>
X-Enigmail-Version: 0.92.0.0
OpenPGP: id=D6F42CA5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Alejandro Bonilla Beeche wrote:
> Jesper,
> 
>    Can you elaborate on how can I do such thing if this is at boot? I
> think you guys need to figure out a way to make these Panics to go into
> some log file.
> 
> I will try to write down some of it as it is at boot.
> 
> .Alejandro

Writing them down is one way, finding a spare computer and using a serial cable
to log is another, and logging them to a remote computer over ethernet using
netconsole is yet another.


- --
[Name      ]   ::  [Matan I. Peled    ]
[Location  ]   ::  [Israel            ]
[Public Key]   ::  [0xD6F42CA5        ]
[Keyserver ]   ::  [keyserver.kjsl.com]
encrypted/signed  plain text  preferred

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDc1jDA7Qvptb0LKURAm9EAKCKVa3vaCoqhWgGQt3FA2lPl7wWXgCfSF8e
PhEs5M7sNDDDBmTAWB0cOZk=
=+XcG
-----END PGP SIGNATURE-----
