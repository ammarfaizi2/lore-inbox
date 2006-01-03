Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751436AbWACPCj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbWACPCj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 10:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbWACPCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 10:02:39 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:27661 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751416AbWACPCj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 10:02:39 -0500
Date: Tue, 3 Jan 2006 16:02:19 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kbuild + kconfig updates for 2.6.16-rc
Message-ID: <20060103150219.GC18012@mars.ravnborg.org>
References: <20060103132035.GA17485@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060103132035.GA17485@mars.ravnborg.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2006 at 02:20:35PM +0100, Sam Ravnborg wrote:
> Accumulated kbuild + kconfig updates for 2.6.16-rc.
> 
> The updates are available in the origin branch at my build git repository.
> Please pull from:
> git://git.kernel.org/pub/scm/linux/kernel/git/sam/kbuild.git from the origin branch.

Due to my ignorance of/missing understanding of branches in git one
patch were missing in the origin branch.

It was in the master branch instead - so I have pulled in the master
branch in the origin branch and updated the kbuild repository.

It is following patch:
Jan-Benedict Glaw
	kbuild: tar-pkg with out-out-tree building

	Sam
