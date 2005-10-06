Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751356AbVJFVFQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbVJFVFQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 17:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbVJFVFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 17:05:16 -0400
Received: from free.hands.com ([83.142.228.128]:40407 "EHLO free.hands.com")
	by vger.kernel.org with ESMTP id S1751356AbVJFVFO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 17:05:14 -0400
Date: Thu, 6 Oct 2005 22:05:06 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Michael Concannon <mike@concannon.net>
Cc: Chase Venters <chase.venters@clientec.com>, Marc Perkel <marc@perkel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
Message-ID: <20051006210506.GY10538@lkcl.net>
References: <20051002204703.GG6290@lkcl.net> <200510041840.55820.chase.venters@clientec.com> <20051005102650.GO10538@lkcl.net> <200510060005.09121.chase.venters@clientec.com> <43453E7F.5030801@concannon.net> <20051006192857.GV10538@lkcl.net> <4345855B.3@concannon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4345855B.3@concannon.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2005 at 04:13:15PM -0400, Michael Concannon wrote:

> 1. It _is_ a file: registry.dat
> 2. It is a binary file at that...

 so don't make the implementation a file.

 or make the contents _of_ the file available via a file system interface.

 quoted for a second time in this thread, this link:

 http://www.bindview.com/Services/RAZOR/Utilities/Unix_Linux/ntreg_readme.cfm

 todd sabin's linux filesystem device driver, which understands nt
 registry fileformat.

	 NTREG
	 -----

	 This is a file system driver for linux, which
	 understands the NT registry file format. With it,
	 you can take registry files from NT, e.g., SAM,
	 SECURITY, etc., and mount them on linux. Currently,
	 it's read-only, though I may add read-write capability
	 in the future.

 http://www.bindview.com/Resources/RAZOR/Files/ntreg.tar.gz

 mentioned for a second time in this thread, the fact that reactos has
 read-write capability into nt hive key (registry) format.

 l.

