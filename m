Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932169AbWFURI2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbWFURI2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 13:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbWFURI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 13:08:28 -0400
Received: from h4x0r5.com ([70.85.31.202]:26378 "EHLO h4x0r5.com")
	by vger.kernel.org with ESMTP id S932169AbWFURI1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 13:08:27 -0400
Date: Wed, 21 Jun 2006 10:08:00 -0700
From: Ryan Anderson <ryan@michonline.com>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net,
       Ben Collins <bcollins@ubuntu.com>,
       Jody McIntyre <scjody@modernduck.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [git pull] ieee1394 tree for 2.6.18
Message-ID: <20060621170759.GA3154@h4x0r5.com>
References: <44954102.3090901@s5r6.in-berlin.de> <Pine.LNX.4.64.0606191902350.5498@g5.osdl.org> <20060620025552.GO27946@ftp.linux.org.uk> <Pine.LNX.4.64.0606192007460.5498@g5.osdl.org> <20060620175321.GA7463@flint.arm.linux.org.uk> <44984CA1.5010308@s5r6.in-berlin.de> <20060620193422.GA10748@flint.arm.linux.org.uk> <44986126.506@s5r6.in-berlin.de> <20060620211524.GU27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060620211524.GU27946@ftp.linux.org.uk>
User-Agent: Mutt/1.5.9i
X-michonline.com-MailScanner: Found to be clean
X-michonline.com-MailScanner-From: ryan@h4x0r5.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2006 at 10:15:24PM +0100, Al Viro wrote:
> (if your version of
> git doesn't suck, git checkout -b for-linus-<date>; git checkout <your
> previous branch> will do it).

git branch for-linus-<date> HEAD

-- 

Ryan Anderson
  sometimes Pug Majere
