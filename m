Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752790AbWKGXX3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752790AbWKGXX3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 18:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753245AbWKGXX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 18:23:28 -0500
Received: from smtp.osdl.org ([65.172.181.4]:53696 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752790AbWKGXX1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 18:23:27 -0500
Date: Tue, 7 Nov 2006 15:23:17 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc: eki@sci.fi, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Missing *eof assignment in Alpha's srm_env driver
In-Reply-To: <20061107230201.GY21485@lug-owl.de>
Message-ID: <Pine.LNX.4.64.0611071522050.3667@g5.osdl.org>
References: <20061107230201.GY21485@lug-owl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 8 Nov 2006, Jan-Benedict Glaw wrote:
> 
> Please pull from
> git://git.kernel.org/pub/scm/linux/kernel/git/jbglaw/vax-linux.git ,
> branch `upstream-linus'.

error: no such remote ref refs/heads/upstream-linus

Did you forget to push it out?

Also, please put the reponame and the branch-name on the same line, like

  "Please pull from

	git://git.kernel.org/pub/scm/linux/kernel/git/jbglaw/vax-linux.git upstream-linus

   to get these changes:
		..."

because that way I can cut-and-paste the thing as a whole line.

		Linus
