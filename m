Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267266AbTAGA2e>; Mon, 6 Jan 2003 19:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267267AbTAGA2e>; Mon, 6 Jan 2003 19:28:34 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:195 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S267266AbTAGA2d>;
	Mon, 6 Jan 2003 19:28:33 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15898.8498.519625.200668@napali.hpl.hp.com>
Date: Mon, 6 Jan 2003 16:37:06 -0800
To: Richard Henderson <rth@twiddle.net>
Cc: davidm@hpl.hp.com, Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel@vger.kernel.org, bjornw@axis.com, geert@linux-m68k.org,
       ralf@gnu.org, mkp@mkp.net, willy@debian.org, anton@samba.org,
       gniibe@m17n.org, kkojima@rr.iij4u.or.jp, Jeff Dike <jdike@karaya.com>
Subject: Re: Userspace Test Framework for module loader porting
In-Reply-To: <20030106144104.A1938@twiddle.net>
References: <20030106022803.902F82C0E2@lists.samba.org>
	<15897.56108.201340.229554@napali.hpl.hp.com>
	<20030106144104.A1938@twiddle.net>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 6 Jan 2003 14:41:04 -0800, Richard Henderson <rth@twiddle.net> said:

  Rich> On Mon, Jan 06, 2003 at 11:38:20AM -0800, David Mosberger
  Rich> wrote:

  >> What about all the problems that Richard Henderson pointed out
  >> with the original in-kernel module loader?  Were those solved?

  Rich> Yes.

OK, that's good.

Rusty, have you maintained the ia64 support of your in-kernel loader?
To be honest, I have less than zero interest in maintaining such code.
I'd rather prefer the old (user-level loader) or the new shared-object
loader.  (Of course, if someone else wants to volunteer, that would be
fine, too... ;-)

	--david
