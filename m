Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262838AbTLHU50 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 15:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262859AbTLHU50
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 15:57:26 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:46234 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262838AbTLHU5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 15:57:17 -0500
Date: Mon, 8 Dec 2003 21:57:14 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Additional clauses to GPL in network drivers
Message-ID: <20031208205714.GB23652@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <87r7zg0zrg.fsf@jay.local.invalid> <MDEHLPKNGKAHNMBLJOLKAEMBIIAA.davids@webmaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKAEMBIIAA.davids@webmaster.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 07 Dec 2003, David Schwartz wrote:

[Jeremy]
> > I don't understand the desire for a notice that is clearly redundant.
> > Due to the nature of the GPL (version 1 or 2), licensing an entire work
> > under it is exactly equivalent to licensing all of the component parts
> > individually under it.
> 
> 	It is definitely redundant. The idea is that if a portion of the
> distribution ever winds up somewhere, the terms are still clear. For
> example, one often finds modified header files or implementation files
> available that don't contain a copy of the GPL or, for that matter, any
> indication that the files included are covered by the GPL.

I usually state in header files that are likely to be taken elsewhere
what license applies without copying the full license or excerpts
thereof into the header. That should be sufficient. There is no need and
no desire to have all possible variants of GPL summaries all over the
tree.

> 	For this reason, I think it makes sense for files to carry some indication
> that they are covered by the GPL. Look, for example, at
> ftp://ftp.scyld.com/pub/network/tulip.c

Too long-winded and IMHO too easily misunderstood. The GPL itself
contains a "how to apply..." (this license to your code) section, and I
see no reason for any deviation from the suggestions stated there.

Even a copyright line and "you may only redistribute this file in
concordance with the terms of the GNU General Public License, version
(whatever applies) (optional "or any later version clause") is
sufficient according to the GPL.

If people actually read the full COPYING file, there'd be no reason for
such stupid GPL "clarifications". Such are not necessary. If the file is
meant to be offered under more than one license (say, BSD "no ad clause
version"/GPL is found sometimes), then that is certainly doable without
GPL "clarifications". The GPL is clear.

Note: IANAL.

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95
