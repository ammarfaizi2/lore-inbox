Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263591AbRFAQB2>; Fri, 1 Jun 2001 12:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263574AbRFAQBS>; Fri, 1 Jun 2001 12:01:18 -0400
Received: from [130.207.47.194] ([130.207.47.194]:11423 "HELO havoc.gtf.org")
	by vger.kernel.org with SMTP id <S263584AbRFAQBC>;
	Fri, 1 Jun 2001 12:01:02 -0400
Message-ID: <3B17BBB9.D8245FFF@mandrakesoft.com>
Date: Fri, 01 Jun 2001 11:58:49 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Danny ter Haar <dth@trinity.hoho.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ethernet still quits
In-Reply-To: <20010601151705.A526@grobbebol.xs4all.nl> <3B17B506.B773B998@mandrakesoft.com> <9f8dba$m5h$1@voyager.cistron.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Danny ter Haar wrote:
> 
> Jeff Garzik  <jgarzik@mandrakesoft.com> wrote:
> >Working on the problem.  You'll need to downgrade the 8139too driver to
> >the current 'ac' patches or a previous version on
> >http://sf.net/projects/gkernel/ temporarily.
> 
> also on :
> www.bzimage.org/kernel-patches/v2.4/alan/v2.4.5/
> 
> 8139_too_work.c (62kB)

That's fine, it is a previous version (0.9.15c).  Note that the current
(broken) 8139too works for some people where earlier versions don't, so
obviously you should not downgrade unless you are having problems.

> And also there:
> 
> patch-2.4.5-ac6-crypto.bz2 (268kB)

What's that?

-- 
Jeff Garzik      | Disbelief, that's why you fail.
Building 1024    |
MandrakeSoft     |
