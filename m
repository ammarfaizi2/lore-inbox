Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281558AbRKUJcm>; Wed, 21 Nov 2001 04:32:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281441AbRKUJcc>; Wed, 21 Nov 2001 04:32:32 -0500
Received: from krista.yaroslavl.ru ([217.15.132.26]:31751 "EHLO
	mailserv.rybinsk.ru") by vger.kernel.org with ESMTP
	id <S281555AbRKUJcV>; Wed, 21 Nov 2001 04:32:21 -0500
Date: Wed, 21 Nov 2001 12:32:15 +0300 (MSK)
From: Dmitri Popov <popov@krista.ru>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation/Changes
In-Reply-To: <20011121022049.GR11449@pervalidus>
Message-ID: <Pine.LNX.4.31.0111211210040.5542-100000@popov.krista.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=koi8-r
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Nov 2001, [unknown-8bit] Frédéric L. W. Meunier wrote:

> BTW, with the addition of ext3 in 2.4.15pre2, maybe it's time
> to require the latest e2fsprogs, 1.25, or include a note
> about ext3 requirements ?

I'd like to note that there is nothing abount quota tools in
Documentation/Changes. I tried to use one of Alan Cox kernels some weeks
ago, and was very surprised, when quota utilities 2.00 stopped working.
And I didn't find any information about correct quota tools in all the
source tree! At last I searched for the latest quota-tools in the Internet
(ftp://atrey.karlin.mff.cuni.cz/pub/local/jack/quota/utils/)
and installed it. Now it works. As I can understand, the current 2.4.*
will also need new utilities.

I also tried to mail the maintainer according to MAINTAINERS, but got no
response yet. If someone knows the exact minimum version of quota tools,
it would be good to include that information into the Changes file.

-- 
Dmitri Popov, mailto:popov@krista.ru


