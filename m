Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264689AbUEOAkF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264689AbUEOAkF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 20:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264681AbUEOAfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 20:35:50 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:30947 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S265341AbUEOAc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 20:32:27 -0400
Subject: Re: [PATCH] scaled-back caps, take 4
From: Albert Cahalan <albert@users.sf.net>
To: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
Cc: Andy Lutomirski <luto@myrealbox.com>, Chris Wright <chrisw@osdl.org>,
       Andy Lutomirski <luto@stanford.edu>,
       Stephen Smalley <sds@epoch.ncsc.mil>,
       Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Valdis.Kletnieks@vt.edu
In-Reply-To: <87hduisgda.fsf@goat.bogus.local>
References: <fa.dt4cg55.jnqvr5@ifi.uio.no> <40A4F163.6090802@stanford.edu>
	 <20040514110752.U21045@build.pdx.osdl.net>
	 <200405141548.05106.luto@myrealbox.com>  <87hduisgda.fsf@goat.bogus.local>
Content-Type: text/plain
Organization: 
Message-Id: <1084572584.951.697.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 14 May 2004 18:09:44 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-05-14 at 20:06, Olaf Dietsche wrote:
> Andy Lutomirski <luto@myrealbox.com> writes:
> 
> > cap_2.6.6-mm2_4.patch: New stripped-back capabilities.
> >
> >  fs/exec.c               |   15 ++++-
> >  include/linux/binfmts.h |    9 ++-
> >  security/commoncap.c    |  130 ++++++++++++++++++++++++++++++++++++++++++------
> >  3 files changed, 136 insertions(+), 18 deletions(-)
> [patch]
> 
> Why don't you provide this as a configurable andycap.c module?

**GROAN**

For those that don't know, this is Andy Cap:
http://picosel.free.fr/andycap/andy_billard.jpg


