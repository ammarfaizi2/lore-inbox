Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132842AbRAGT5Q>; Sun, 7 Jan 2001 14:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133014AbRAGT5H>; Sun, 7 Jan 2001 14:57:07 -0500
Received: from sgi.SGI.COM ([192.48.153.1]:40060 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S132842AbRAGT4x>;
	Sun, 7 Jan 2001 14:56:53 -0500
Date: Sun, 7 Jan 2001 13:56:26 -0600
From: Nathan Straz <nstraz@sgi.com>
To: "Michael D. Crawford" <crawford@goingware.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What test suites can you tell me about?
Message-ID: <20010107135626.A3747@sgi.com>
Mail-Followup-To: "Michael D. Crawford" <crawford@goingware.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3A57A87B.BA60FF9B@goingware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3A57A87B.BA60FF9B@goingware.com>; from crawford@goingware.com on Sat, Jan 06, 2001 at 11:21:31PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 06, 2001 at 11:21:31PM +0000, Michael D. Crawford wrote:
> Can you tell me about any ready-to-use test suites, for any software
> package that should run under Linux, that I can build and run to test
> the new kernel?

The Linux Test Project (http://oss.sgi.com/projects/ltp/) was set up to
create a set of automated tests for Linux.  The project currently
consists of about 100 tests and a simple test driver.  Grab the source
from anonymous CVS as the tarballs are out of date.  


-- 
Nate Straz                                              nstraz@sgi.com
sgi, inc                                           http://www.sgi.com/
Linux Test Project                    http://oss.sgi.com/projects/ltp/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
