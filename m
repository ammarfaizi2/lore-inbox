Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261266AbULAOyH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261266AbULAOyH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 09:54:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261267AbULAOyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 09:54:07 -0500
Received: from dsl093-002-214.det1.dsl.speakeasy.net ([66.93.2.214]:31111 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S261266AbULAOyF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 09:54:05 -0500
Date: Wed, 1 Dec 2004 09:54:11 -0500
To: Jan Kasprzak <kas@fi.muni.cz>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net,
       trond.myklebust@fys.uio.no, neilb@cse.unsw.edu.au, torvalds@osdl.org
Subject: Re: [PATCH] NFS mount hang fix
Message-ID: <20041201145411.GA27612@fieldses.org>
References: <20041026141148.GM6408@fi.muni.cz> <20041026150640.GA24881@fieldses.org> <20041027121543.GH4724@fi.muni.cz> <20041125122902.GE27939@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041125122902.GE27939@fi.muni.cz>
User-Agent: Mutt/1.5.6+20040907i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2004 at 01:29:02PM +0100, Jan Kasprzak wrote:
> 	It seems this patch did not make it into Linus' tree
> (at least it is not in 2.6.10-rc2). Can you resend it to Linus, please?

It's in recent -bk snapshots.--b.
