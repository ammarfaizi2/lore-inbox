Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263517AbTDGPGp (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 11:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263520AbTDGPGp (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 11:06:45 -0400
Received: from 12-237-214-24.client.attbi.com ([12.237.214.24]:43124 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id S263517AbTDGPGm (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 11:06:42 -0400
Message-ID: <3E9196B6.8030601@acm.org>
Date: Mon, 07 Apr 2003 10:18:14 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Louis Zhuang <louis.zhuang@linux.co.intel.com>
CC: OPENIPMIML <openipmi-developer@lists.sourceforge.net>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RESEND] socket interface for IPMI against 2.5.66-bk
References: <1049363835.1168.6.camel@hawk.sh.intel.com>	 <3E8C63D4.8040807@mvista.com> <1049433965.1165.2.camel@hawk.sh.intel.com>	 <3E8D9CD2.8060506@acm.org> <1049678799.1165.24.camel@hawk.sh.intel.com>
In-Reply-To: <1049678799.1165.24.camel@hawk.sh.intel.com>
X-Enigmail-Version: 0.74.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Louis Zhuang wrote:

>On Fri, 2003-04-04 at 22:55, Corey Minyard wrote:
>
>>I've merged this in, but I made some adjustments:
>>
>>    * I added a copyright to include/net/ipmi.h (just copied from
>>net/ipmi/af_ipmi.c)
>
>Just curious, should we add copyright even when I have announced it by
>'MODULE_LICENSE("GPL")'? I dislike too many leagal text in code...

I guess it's up to you, but you had added the header in all files but
that one.

Corey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE+kZa0IXnXXONXERcRAtd0AKCjBePfZPzdE+c9n/aBH0yqYI3SGwCdGZZc
GbHp0DsHLsa1yF/W/T7kYRc=
=pg9e
-----END PGP SIGNATURE-----


