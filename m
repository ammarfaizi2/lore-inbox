Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263500AbTLOMDv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 07:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263504AbTLOMDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 07:03:50 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:11910 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S263500AbTLOMDu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 07:03:50 -0500
To: davidm@hpl.hp.com
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, jbarnes@sgi.com,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch] quite down SMP boot messages
References: <yq0fzfr32ib.fsf@wildopensource.com>
	<20031212221609.GC314@elf.ucw.cz>
	<16346.16576.987077.529284@napali.hpl.hp.com>
From: Jes Sorensen <jes@wildopensource.com>
Date: 15 Dec 2003 06:57:09 -0500
In-Reply-To: <16346.16576.987077.529284@napali.hpl.hp.com>
Message-ID: <yq0ekv6z42y.fsf@wildopensource.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "David" == David Mosberger <davidm@napali.hpl.hp.com> writes:

David> Sounds promising to me.  I also dislike the verbosity, but
David> getting rid of the messages completely makes me nervous, too,
David> because sometimes things do fail and then it's invaluable to
David> have some idea of how far the boot got (even if the person
David> booting the machines has no clue what the funny symbols on his
David> screen actually mean).

This is exactly why I added the smpverbose boot option so one can
reenable all the messages.

Cheers,
Jes
