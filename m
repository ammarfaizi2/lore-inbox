Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314665AbSDTRFt>; Sat, 20 Apr 2002 13:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314664AbSDTRFs>; Sat, 20 Apr 2002 13:05:48 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:45327 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S314665AbSDTRFr>; Sat, 20 Apr 2002 13:05:47 -0400
Message-ID: <3CC19FD9.1D3F8168@linux-m68k.org>
Date: Sat, 20 Apr 2002 19:05:29 +0200
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Lang <dlang@diginsite.com>
CC: Jeff Garzik <garzik@havoc.gtf.org>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove Bitkeeper documentation from Linux tree
In-Reply-To: <Pine.LNX.4.44.0204200921000.389-100000@dlang.diginsite.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

David Lang wrote:

> If they start to be tools that are used to submit changes to the kernel
> then yes they should be included.

"start"? People used other source management system already before bk.

> remember that the reason for the bitkeeper documentation is to help people
> setup a tree that linux (and others) can pull from, not to help people
> setup their own tree just for them to hack on.

The problem is that this suggest, bk would be the choice for kernel
development or even usage. They are lots of kernel projects, which use
cvs, but noone before considered submitting extensive cvs documentation
into the kernel.

bye, Roman
