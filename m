Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261417AbVBGOAa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbVBGOAa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 09:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbVBGOAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 09:00:30 -0500
Received: from mail.pixelwings.com ([194.152.163.212]:19432 "EHLO
	pixelwings.com") by vger.kernel.org with ESMTP id S261417AbVBGOAY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 09:00:24 -0500
Message-ID: <4207746A.2070401@tequila.co.jp>
Date: Mon, 07 Feb 2005 23:00:10 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.5) Gecko/20041206 Thunderbird/1.0 Mnenhy/0.7
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andries Brouwer <aebr@win.tue.nl>
CC: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Pozsar Balazs <pozsy@uhulinux.hu>,
       Christoph Hellwig <hch@infradead.org>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       John Richard Moser <nigelenki@comcast.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: msdos/vfat defaults are annoying
References: <4205AC37.3030301@comcast.net> <20050206070659.GA28596@infradead.org> <20050206232108.GA31813@ojjektum.uhulinux.hu> <20050207003610.GP8859@parcelfarce.linux.theplanet.co.uk> <4207104C.1000604@tequila.co.jp> <20050207112914.GB2686@pclin040.win.tue.nl>
In-Reply-To: <20050207112914.GB2686@pclin040.win.tue.nl>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 07.02.2005 20:29, Andries Brouwer wrote:

> Making a symlink /etc/filesystems -> /proc/filesystems is
> meaningless.

well to be honest, I didn't even know Gentoo makes a symlink here, but
I'll definitly will make bug entry for that.

Perhaps its a default setting. eg Debian doesn't have a /etc/filesystems
file by defauly anyway.

> It is not true that vfat is universally better than msdos.
> Some need one, some need the other.

but to be honest, most times I need vfat, and I actually haven't
encountered a time when I need msdos.

lg, clemens

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD4DBQFCB3RpjBz/yQjBxz8RAlQBAJjj0IIhxCPWvWinMpi6J5UOJ9bBAJ9oQnI4
A6sIi+MzKiFbvpLIiQI1YQ==
=rmlN
-----END PGP SIGNATURE-----
