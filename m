Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261351AbTCTRhn>; Thu, 20 Mar 2003 12:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261376AbTCTRhn>; Thu, 20 Mar 2003 12:37:43 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:62880 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S261351AbTCTRhn>; Thu, 20 Mar 2003 12:37:43 -0500
Date: Thu, 20 Mar 2003 18:48:42 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: re: Deprecating .gz format on kernel.org
Message-ID: <20030320174842.GC6083@louise.pinerecords.com>
References: <3E78D0DE.307@zytor.com> <20030320163207.GH28454@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030320163207.GH28454@lug-owl.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [jbglaw@lug-owl.de]
> 
> On Wed, 2003-03-19 12:19:42 -0800, H. Peter Anvin <hpa@zytor.com>
> wrote in message <3E78D0DE.307@zytor.com>:
> > Hello everyone,
> > 
> > At some point it probably would make sense to start deprecating .gz
> > format files from kernel.org.
> 
> However, please keep in mind that it's a *PITA* if you're working on a
> machine with not > 500MHz and > 128MB RAM:

Well, you see, hpa probably made a mistake in his original proposal.

Likely he meant to say he intended to deprecate bz2 and was about
to introduce lzo instead.  ;)

-- 
Tomas Szepe <szepe@pinerecords.com>
