Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261917AbVEWQmv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261917AbVEWQmv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 12:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261913AbVEWQmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 12:42:50 -0400
Received: from rev.193.226.233.9.euroweb.hu ([193.226.233.9]:12048 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261915AbVEWQmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 12:42:09 -0400
To: raven@themaw.net
CC: linux-fsdevel@vger.kernel.org, autofs@linux.kernel.org,
       linux-kernel@vger.kernel.org
In-reply-to: <Pine.LNX.4.62.0505232339250.3469@donald.themaw.net>
	(raven@themaw.net)
Subject: Re: [VFS-RFC] autofs4 and bind, rbind and move mount requests
References: <Pine.LNX.4.62.0505232041410.8361@donald.themaw.net>
 <E1DaERw-0002cC-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.62.0505232339250.3469@donald.themaw.net>
Message-Id: <E1DaG04-0002hk-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 23 May 2005 18:41:56 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Perhaps not in this case.

Maybe I'm misunderstanding.

Are you talking about an automounted filesystem, or the autofs
filesystem itself.

With the later I can well imagine that you have problems with bind and
move.

Miklos
