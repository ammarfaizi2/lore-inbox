Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311917AbSDEC6U>; Thu, 4 Apr 2002 21:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312134AbSDEC6K>; Thu, 4 Apr 2002 21:58:10 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:49206 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S311917AbSDEC6C>; Thu, 4 Apr 2002 21:58:02 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: davidw@dedasys.com (David N. Welton), linux-kernel@vger.kernel.org
Subject: Re: forth interpreter as kernel module
In-Reply-To: <E16tHSB-00078F-00@the-village.bc.nu>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 04 Apr 2002 19:51:19 -0700
Message-ID: <m1y9g2q2mw.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > I would be interested in comments on what should be fixed in the code,
> > although I may not have time to act on them.
> 
> Strange. The one area forth does have sort of relevance may be outside the
> x86 world. The portable boot rom standards (the one everyone ignored for
> x86) is all about forth stuff. I don't know if anyone has use for a forth
> engine that can speak that ?

The openbios guys are working on it.  I haven't played with it but they
seem to be makeing some progress.

Eric
