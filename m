Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268805AbUIBSi0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268805AbUIBSi0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 14:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268405AbUIBSi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 14:38:26 -0400
Received: from as8-6-1.ens.s.bonet.se ([217.215.92.25]:14518 "EHLO
	zoo.weinigel.se") by vger.kernel.org with ESMTP id S268388AbUIBSiU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 14:38:20 -0400
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Hans Reiser <reiser@namesys.com>, Linus Torvalds <torvalds@osdl.org>,
       David Masover <ninja@slaphack.com>, Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives
References: <20040826150202.GE5733@mail.shareable.org>
	<200408282314.i7SNErYv003270@localhost.localdomain>
	<20040901200806.GC31934@mail.shareable.org>
	<Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org>
	<20040902002431.GN31934@mail.shareable.org>
	<413694E6.7010606@slaphack.com>
	<Pine.LNX.4.58.0409012037300.2295@ppc970.osdl.org>
	<4136A14E.9010303@slaphack.com>
	<Pine.LNX.4.58.0409012259340.2295@ppc970.osdl.org>
	<4136C876.5010806@namesys.com>
	<Pine.LNX.4.58.0409020030220.2295@ppc970.osdl.org>
	<4136E0B6.4000705@namesys.com> <14260000.1094149320@flay>
From: Christer Weinigel <christer@weinigel.se>
Organization: Weinigel Ingenjorsbyra AB
Date: 02 Sep 2004 20:38:19 +0200
In-Reply-To: <14260000.1094149320@flay>
Message-ID: <m3llfsikis.fsf@zoo.weinigel.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> writes:

> > For 30 years nothing much has happened in Unix filesystem semantics 
> > because of sheer cowardice 
> 
> Or because it works fine, and isn't broken.

I've heard the same argument a lot of times.  People complaining that
Unix is so seventies because it sticks to the old boring philosophy of
everything is a file and that a file is a stream of bytes, nothing
more.  Modern operating systems such as VMS with basic database
handling in the OS itself, or MacOS or NT with named streams is so
much more modern.  Why don't we get with the times?

It may be because just because of the simplicity it's fairly easy to
use, harder to break och does one thing well.  If you want structured
storage, use a database, on top of the low level primitives, or use
multiple files in a directory.  Why complicate things?

  /Christer

-- 
"Just how much can I get away with and still go to heaven?"

Freelance consultant specializing in device driver programming for Linux 
Christer Weinigel <christer@weinigel.se>  http://www.weinigel.se
