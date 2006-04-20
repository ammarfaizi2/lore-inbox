Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751169AbWDTXGZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbWDTXGZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 19:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbWDTXGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 19:06:25 -0400
Received: from wproxy.gmail.com ([64.233.184.229]:57877 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751169AbWDTXGY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 19:06:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:openpgp:content-type:content-transfer-encoding;
        b=iXYc0aAJ5cDVVOObL/WdbR8SP6QKX+YGXWXv0PRmvv01lXjW96l954/J/DqfbGUk0b6REWPsaBgwIlFgtz6A/VE2YYzp4Z2KNKmv++/TLHrrjDkAZMhtJ2sfBUh0rudiJ1yVoymR/HtcGhO72qUNT9Hhzvbdi2t7dT+HHlxQfBY=
Message-ID: <44481571.4000208@gmail.com>
Date: Fri, 21 Apr 2006 06:12:49 +0700
From: Mikado <mikado4vn@gmail.com>
Reply-To: mikado4vn@gmail.com
Organization: IcySpace.net
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: "'Linux kernel'" <linux-kernel@vger.kernel.org>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Mike Galbraith <efault@gmx.de>, Hua Zhong <hzhong@gmail.com>
Subject: Re: Which process is associated with process ID 0 (swapper)
References: <004801c664c7$e80acfd0$853d010a@nuitysystems.com> <Pine.LNX.4.61.0604210019440.28841@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0604210019440.28841@yvahk01.tjqt.qr>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=65ABD897
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jan Engelhardt wrote:
>> Swapper is the idle process, which swaps nothing. Its name is historic and it doesn't appear in /proc because for_each_process()
>> skips it.
>>
> Anyone objecting to renaming it?
> 
> 
> Jan Engelhardt

Please focus on my main question. Thank you!

Mikado.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFESBVxNWc9T2Wr2JcRAseYAJ9Fd8/IN9pk/iAYQYc1MXHxt/T9WgCgmFpx
j3wvQBiYBmDjPO1q4Rc8OB8=
=eNTU
-----END PGP SIGNATURE-----
