Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267964AbTAKStA>; Sat, 11 Jan 2003 13:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267973AbTAKStA>; Sat, 11 Jan 2003 13:49:00 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:17413 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267964AbTAKSs7>; Sat, 11 Jan 2003 13:48:59 -0500
Date: Sat, 11 Jan 2003 18:57:44 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Ulrich Drepper <drepper@redhat.com>
Cc: davidm@hpl.hp.com, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: make AT_SYSINFO platform-independent
Message-ID: <20030111185744.A5009@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ulrich Drepper <drepper@redhat.com>, davidm@hpl.hp.com,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org
References: <200301110645.h0B6jQRu026921@napali.hpl.hp.com> <20030111110717.A24094@infradead.org> <3E2067FE.4060803@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3E2067FE.4060803@redhat.com>; from drepper@redhat.com on Sat, Jan 11, 2003 at 10:52:46AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 11, 2003 at 10:52:46AM -0800, Ulrich Drepper wrote:
> Christoph Hellwig wrote:
> 
> > I think it should be updated.  There is no released glibc or stable kernel
> > with that number yet.
> 
> Actually, we've included the support already in some published code.  If
> you want to complain to somebody about this, do it to the person who is
> responsible for distributing this code.  His email address is
> 
>    torvalds@transmeta.com
> 
> Make sure you react with the same nastiness as if I would have made the
> decision, OK?

-EWHATSUP

Who is we?  And why should I care who selected that number.  There is no
glibc release yet and no stable kernel release yet with that number.
Interfaces change during 2.5 (see the sys_security and largepage syscall
removal) and that's okay.  There was no nastiness involved in my
suggestion.

