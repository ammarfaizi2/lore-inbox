Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268098AbTAKS6H>; Sat, 11 Jan 2003 13:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268100AbTAKS6H>; Sat, 11 Jan 2003 13:58:07 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:41380
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S268098AbTAKS6G>; Sat, 11 Jan 2003 13:58:06 -0500
Message-ID: <3E206B41.2090203@redhat.com>
Date: Sat, 11 Jan 2003 11:06:41 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030109
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: davidm@hpl.hp.com, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: make AT_SYSINFO platform-independent
References: <200301110645.h0B6jQRu026921@napali.hpl.hp.com> <20030111110717.A24094@infradead.org> <3E2067FE.4060803@redhat.com> <20030111185744.A5009@infradead.org>
In-Reply-To: <20030111185744.A5009@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

> Who is we?  And why should I care who selected that number.

It's not about who selected the number, it's about who's responsible for
distributing binaries which use the currently used number.


> There is no
> glibc release yet and no stable kernel release yet with that number.

Of course there is.  You better don't talk about thinks you don't know.


> Interfaces change during 2.5 (see the sys_security and largepage syscall
> removal) and that's okay.  There was no nastiness involved in my
> suggestion.

You don't get it.  I would never have distributed binaries with the
current code if it wouldn't have been requested along with the guarantee
that the current interface is stable and final.

-- 
--------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------

