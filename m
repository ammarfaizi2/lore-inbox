Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263209AbUCMWU5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 17:20:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263204AbUCMWUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 17:20:34 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:30256 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S263217AbUCMWSv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 17:18:51 -0500
Date: Sat, 13 Mar 2004 23:21:49 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Marek Szuba <scriptkiddie@wp.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4, or what I still don't quite like about the new stable branch
Message-ID: <20040313222149.GB1998@mars.ravnborg.org>
Mail-Followup-To: Marek Szuba <scriptkiddie@wp.pl>,
	linux-kernel@vger.kernel.org
References: <S263158AbUCMS0h/20040313182637Z+893@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <S263158AbUCMS0h/20040313182637Z+893@vger.kernel.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2004 at 07:27:12PM +0100, Marek Szuba wrote:
> 
> 3. Junk left in the source root after 'make clean'. Is it really
> supposed to stay there? If so, could I get told why? By "it" I mean the
> two .tmp_vmlinux and the four .tmp_kallsyms files, taking up
> approximately 8 MB of disk space on my system.

Already addressed and included lastest snapshot of Linus's tree.
See http://linus.bkbits.net:8080/linux-2.5/cset@1.1608.78.41?nav=index.html|ChangeSet@-2d
[Do not expect link to work for more than a few hours or days, since cset numbers
may vary over time]

The fix will show up in 2.6.5.

But thanks for the input!

	Sam
