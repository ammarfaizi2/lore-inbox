Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263281AbUJ2Lh7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263281AbUJ2Lh7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 07:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263260AbUJ2Lh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 07:37:58 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:1960 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id S263299AbUJ2Lgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 07:36:50 -0400
Message-ID: <41822B0E.6000707@t-online.de>
Date: Fri, 29 Oct 2004 13:35:42 +0200
From: "Harald Dunkel" <harald.dunkel@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc4-mm1: undefined reference to `hpet_alloc'
References: <416E343C.70900@t-online.de> <20041027175727.GA2713@stusta.de> <41822535.2070409@t-online.de>
In-Reply-To: <41822535.2070409@t-online.de>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: bVRMyQZCgeC3zP8FVsKkKlqc2h5rp7TWrhPxe8cLe46uOK2MdgFcEO
X-TOI-MSGID: eb4f02ac-2cf5-47d8-9572-444c360f01b0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Harald Dunkel wrote:
| Adrian Bunk wrote:
| |
| | I tried to reproduce your problem in 2.6.10-rc1-mm1, but I didn't get
| | the link error.
| |
|
| I can reproduce it using "make oldconfig" in the 2.6.10-rc1
| source tree. Just copy my 2.6.9 .config into the source dir,
| run oldconfig and accept the default for all questions.
|

The link fialure is gone for 2.6.10-rc1. Sorry, I should
have checked before sending a reply.


Regards

Harri
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFBgisOUTlbRTxpHjcRAvYQAJ9iD6tccNuSk7zw+5aLNiLhCb4nDwCeIuQ4
8Zk04WABfUj30FAqaaTrSEs=
=GlDY
-----END PGP SIGNATURE-----
