Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263746AbUC3Qvt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 11:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263754AbUC3Qvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 11:51:45 -0500
Received: from [81.168.75.8] ([81.168.75.8]:42606 "EHLO henning.makholm.net")
	by vger.kernel.org with ESMTP id S263746AbUC3Qvk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 11:51:40 -0500
To: debian-devel@lists.debian.org, debian-legal@lists.debian.org,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: Binary-only firmware covered by the GPL?
References: <8RnZwD.A.91B.qHYaAB@murphy> <40698AE4.7020006@almg.gov.br>
X-My-Web-page: http://www.diku.dk/~makholm/
From: Henning Makholm <henning@makholm.net>
Date: 30 Mar 2004 17:51:38 +0100
In-Reply-To: <40698AE4.7020006@almg.gov.br>
Message-ID: <87y8picm79.fsf@kreon.lan.henning.makholm.net>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Scripsit Humberto Massa <humberto.massa@almg.gov.br>

> to modify the fw[], at least *legally* is MHO that any
> recipient/redistributor of the file _can_ and _must_ consider the file
> in *that* format as the preferred form for modification (pf4m) *and*,
> considering it the source code, follow the directions of the GPL in
> respect to modification and redistribution.

No, law does not work that way. The phrase "preferred form for
modification" has a clear enough, if somewhat fuzzy, literal meaning,
and one cannot *implicitly* make it mean something that directly
contrast to the literal meaning. If nobody *actually* prefers the
binary blob for modification, then the binary blob is *not* the
preferred form for modification. That's irrespective of whether the
copyright holder behaves inconsistently.

> * the /status quo/ obtained by observation of the previous item
> prevails _until somebody proves_ that the fw[] = {} is *not* the
> source code;

And Debian's approach to software freedom doesn't work that way
either. We treat software as non-free and non-distributable unless and
until we see good and self-consistent evidence that it is actually
free and distributable. The "burden of proof", to the extent that
expression applies, is always on the side that claims that the
software in question is OK for Debian to distribute.

-- 
Henning Makholm                "Nu kommer han. Kan du ikke høre knallerten?"
