Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129188AbRBEGw7>; Mon, 5 Feb 2001 01:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129468AbRBEGwa>; Mon, 5 Feb 2001 01:52:30 -0500
Received: from runyon.cygnus.com ([205.180.230.5]:8433 "EHLO cygnus.com")
	by vger.kernel.org with ESMTP id <S129075AbRBEGwS>;
	Mon, 5 Feb 2001 01:52:18 -0500
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: Pierre Rousselet <pierre.rousselet@wanadoo.fr>,
        David Ford <david@linux.com>, devfs@oss.sgi.com,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] devfsd, compiling on glibc22x
In-Reply-To: <3A7383B2.19DDD006@linux.com> <3A73C1D8.578AEEE@wanadoo.fr>
	<m3wvbgnnk3.fsf@otr.mynet.cygnus.com>
	<200102050631.f156Vje04234@vindaloo.ras.ucalgary.ca>
Reply-To: drepper@cygnus.com (Ulrich Drepper)
X-fingerprint: BE 3B 21 04 BC 77 AC F0  61 92 E4 CB AC DD B9 5A
From: Ulrich Drepper <drepper@redhat.com>
Date: 04 Feb 2001 22:51:41 -0800
In-Reply-To: Richard Gooch's message of "Sun, 4 Feb 2001 23:31:45 -0700"
Message-ID: <m3lmrl62rm.fsf@otr.mynet.cygnus.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch <rgooch@ras.ucalgary.ca> writes:

> So why do old binaries (compiled with glibc 2.1.3) segfault when they
> call dlsym() with RTLD_NEXT?  Even newly compiled binaries (with glibc
> 2.2) still segfault.

What do you ask me?  You wrote the code.

-- 
---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
