Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274944AbTHFJDo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 05:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274942AbTHFJDo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 05:03:44 -0400
Received: from c210-49-26-171.randw1.nsw.optusnet.com.au ([210.49.26.171]:24486
	"EHLO mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id S274944AbTHFJDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 05:03:43 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16176.50279.142032.297261@wombat.chubb.wattle.id.au>
Date: Wed, 6 Aug 2003 19:03:35 +1000
To: Martin Pool <mbp@sourcefrog.net>
Cc: hsdm <hsdm@hsdm.com>, linux-kernel@vger.kernel.org
Subject: Re: Is it possible to add this feature.
In-Reply-To: <pan.2003.08.06.07.47.15.831811@sourcefrog.net>
References: <3F3049D0.6040804@hsdm.com>
	<20030806003054.GN6541@kurtwerks.com>
	<20030806005348.GB15764@matchmail.com>
	<pan.2003.08.06.07.47.15.831811@sourcefrog.net>
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Martin" == Martin Pool <mbp@sourcefrog.net> writes:

Martin> On Tue, 05 Aug 2003 17:53:48 -0700, Mike Fedyk wrote:
>> On Tue, Aug 05, 2003 at 08:30:54PM -0400, Kurt Wall wrote:
>>> Quoth hsdm: > Is it posible to limit the amount of memory or CPU
>>> time per user?
>> Basically, no.

Martin> Mike is correct that you cannot have system-wide per-user
Martin> limits at the moment, at least in the standard kernel.
Martin> However, it would be possible to add it, if you find somebody
Martin> to develop it for you.

Aurema have already done something similar:  http://www.aurema.com/
however, I don't believe it's available for 2.6.0, and it is a
commercial product.

Peter C
