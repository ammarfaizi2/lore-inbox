Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263240AbUJ2LMQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263240AbUJ2LMQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 07:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263241AbUJ2LMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 07:12:16 -0400
Received: from mailout07.sul.t-online.com ([194.25.134.83]:23769 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id S263240AbUJ2LMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 07:12:10 -0400
Message-ID: <41822535.2070409@t-online.de>
Date: Fri, 29 Oct 2004 13:10:45 +0200
From: "Harald Dunkel" <harald.dunkel@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc4-mm1: undefined reference to `hpet_alloc'
References: <416E343C.70900@t-online.de> <20041027175727.GA2713@stusta.de>
In-Reply-To: <20041027175727.GA2713@stusta.de>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: bpk25oZYwe7f0kv2ePA0o2es0dsw3pPRnbCp90j+O4lqeMsaPJ0ZkS
X-TOI-MSGID: 57f483ea-f1b5-4f90-8c68-9b0fe41c71e3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Adrian Bunk wrote:
|
| I tried to reproduce your problem in 2.6.10-rc1-mm1, but I didn't get
| the link error.
|

I can reproduce it using "make oldconfig" in the 2.6.10-rc1
source tree. Just copy my 2.6.9 .config into the source dir,
run oldconfig and accept the default for all questions.

But my .config.gz is 13 KByte compressed. I will send it in a
separate EMail to Adrian only. If anybody else is interested,
please mail.


Regards

Harri
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFBgiU1UTlbRTxpHjcRAiULAJ4mXJjmiMAuIF6oJ//stTPsDyWjfwCfTFFW
XSXQ1aRXlfdDLM+5C4PrGDw=
=KMaU
-----END PGP SIGNATURE-----
