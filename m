Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262577AbTJTOBk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 10:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262580AbTJTOBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 10:01:40 -0400
Received: from mail.g-housing.de ([62.75.136.201]:59108 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S262577AbTJTOBj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 10:01:39 -0400
Message-ID: <3F93EABF.5000805@g-house.de>
Date: Mon, 20 Oct 2003 16:01:35 +0200
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.4) Gecko/20031010 Debian/1.4-6
X-Accept-Language: de-de, de, en-gb, en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: RH7.3 can't compile 2.6.0-test8
References: <0c1101c396f4$00bfeaf0$24ee4ca5@DIAMONDLX60>
In-Reply-To: <0c1101c396f4$00bfeaf0$24ee4ca5@DIAMONDLX60>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Norman Diamond schrieb:
[...]
> fs/proc/array.c:398: confused by earlier errors, bailing out
> make[2]: *** [fs/proc/array.o] エラー 1
> make[1]: *** [fs/proc] エラー 2
> make: *** [fs] エラー 2
> [ndiamond@c1pc40 linux-2.6.0-test8]$ gcc -v
> Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/2.96/specs
> gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-110)
> [ndiamond@c1pc40 linux-2.6.0-test8]$ rpm -qa binutils
> binutils-2.11.93.0.2-11

did you try with a gcc 3.x too? perhaps it's (only) a compiler issue...

Christian.
-- 
BOFH excuse #285:

Telecommunications is upgrading.

