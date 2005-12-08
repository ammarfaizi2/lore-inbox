Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbVLHHrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbVLHHrE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 02:47:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbVLHHrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 02:47:04 -0500
Received: from mx.laposte.net ([81.255.54.11]:15743 "EHLO mx.laposte.net")
	by vger.kernel.org with ESMTP id S1750704AbVLHHrB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 02:47:01 -0500
Message-ID: <4397E427.2070702@laposte.net>
Date: Thu, 08 Dec 2005 08:43:35 +0100
From: Nicolas Mailhot <nicolas.mailhot@laposte.net>
User-Agent: Mail/News 1.5 (X11/20051129)
MIME-Version: 1.0
To: Felix Oxley <lkml@oxley.org>
CC: linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Jesse Barnes <jesse.barnes@intel.com>,
       Pekka Enberg <penberg@cs.helsinki.fi>,
       Jon Masters <jonmasters@gmail.com>,
       Grahame White <grahame@regress.homelinux.org>,
       Benjamin LaHaise <bcrl@kvack.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, Lars Marowsky-Bree <lmb@suse.de>,
       "linux-os ((Dick Johnson))" <linux-os@analogic.com>,
       Rik van Riel <riel@redhat.com>, Dirk Steuwer <dirk@steuwer.de>,
       Andrea Arcangeli <andrea@suse.de>, Lee Revell <rlrevell@joe-job.com>
Subject: Re: Linux Hardware Quality Labs (was: Linux in a binary world...
 a doomsday scenario)
References: <6DAD0850-4943-416E-9E7B-095C6B412DD0@oxley.org>
In-Reply-To: <6DAD0850-4943-416E-9E7B-095C6B412DD0@oxley.org>
X-Enigmail-Version: 0.93.1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felix Oxley wrote:

> Unlike previous lists of equipment that works with Linux, this would of
> course have to be centrally administered.
> Simply, hardware manufacturers would be able to use the LHQL logo
> (whatever it looks like or is called) once their kit had been certified,
> the primary requirement for which would be either that a  fully featured
> open source driver was available or that all the relevant documentation
> had been put in to the public domain so that anybody could write one.

I think the current focus on the logo idea is pretty sad. The only real
"feature" a logo adds is it will have to be maintained by Someone Else.
Which is always nice. Except when the real info is in the kernel
maintainers heads, as is the real love of free software, being
maintained by Someone Else means it'll fail.

A good exhaustive online centralised hardware database, blessed and
maintained by kernel people, will have influence with or without a logo.

A pretty logo/HQL program without kernel people involvement will fail
quickly.

The problem with maintaining your own database is its a lot of work (as
Lee Revell pointed). However, if kernel people don't want the system to
be abused, distorted, etc they'll have to make this effort.

Kernel people complain users don't buy the right hardware, but they
don't bother pointing out which hardware is good. I'm pretty sure when
*they* buy new systems they don't do the long hours of googling and ML
analysis they'd want the users to perform (because right now that's what
needed to find out which hardware is linux-friendly)

Also, kernel people use the power of the internet all day round but put
their faith in a paper logo. Which is pretty ridiculous. Give users a
good database and they won't need the paper thingy (not to mention
drivers are completed after hardware ships, so all the already-packaged
hardware won't get a linux logo by magic)

Regards,

-- 
Nicolas Mailhot
