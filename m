Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbTEEXJu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 19:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262056AbTEEXJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 19:09:49 -0400
Received: from air-2.osdl.org ([65.172.181.6]:53188 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261706AbTEEXJt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 19:09:49 -0400
Subject: Re: Linux 2.5.69
From: John Cherry <cherry@osdl.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030505213909.GA2431@mars.ravnborg.org>
References: <Pine.LNX.4.44.0305041739020.1737-100000@home.transmeta.com>
	 <1052168752.27203.175.camel@cherrypit.pdx.osdl.net>
	 <20030505213909.GA2431@mars.ravnborg.org>
Content-Type: text/plain
Organization: 
Message-Id: <1052176936.27203.260.camel@cherrypit.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 05 May 2003 16:22:16 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, the diff would be useful in many cases.  I'll shoot for this by the
next kernel drop.

In the mean time, you can do your own diffs of changes you are
interested in.  The last link in the table (the Files tab) will give you
a list of files that are logs of the modules that have warnings or
errors.  For instance, warnings/errors for the md module would be in
2.5.69.log.md.txt.

Cheers,
John

On Mon, 2003-05-05 at 14:39, Sam Ravnborg wrote:
> On Mon, May 05, 2003 at 02:05:52PM -0700, John Cherry wrote:
> > 
> > modules (allmodconfig)    1975 warnings        1567 warnings
> >                             60 errors            57 errors
> 
> Is it possible to see a diff of .68 and .69 to see where the
> improvements came from?
> I did not find it on the web-page. If not possible take this as a 
> feature request.
> 
> 	Sam

