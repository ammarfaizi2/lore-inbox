Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932606AbVJELOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932606AbVJELOq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 07:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932612AbVJELOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 07:14:46 -0400
Received: from free.hands.com ([83.142.228.128]:60837 "EHLO free.hands.com")
	by vger.kernel.org with ESMTP id S932606AbVJELOp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 07:14:45 -0400
Date: Wed, 5 Oct 2005 12:14:38 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Valdis.Kletnieks@vt.edu
Cc: "D. Hazelton" <dhazelton@enter.net>, Marc Perkel <marc@perkel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
Message-ID: <20051005111437.GT10538@lkcl.net>
References: <20051002204703.GG6290@lkcl.net> <4342DC4D.8090908@perkel.com> <200510050122.39307.dhazelton@enter.net> <20051005100942.GN10538@lkcl.net> <200510051023.j95ANApC015320@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510051023.j95ANApC015320@turing-police.cc.vt.edu>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2005 at 06:23:09AM -0400, Valdis.Kletnieks@vt.edu wrote:

> >  i trust that POSIX has not been hard-coded into the entire design of
> >  the linux kernel filesystem architecture _just_ because it's ... POSIX.
> 
> No, what got hard-coded were the concepts of inodes as the actual description
> of filesystem objects, directories as lists of name-inode pairs, and the whole
> user/group/other permission thing.  "unlink depends on the directory
> permissions not the object unlinked" has been the semantic that people depended
> on 

 fortunately, selinux has begun the path away from that kind of implicit
 ruling.

 l.

