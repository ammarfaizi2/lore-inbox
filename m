Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261195AbVEFMUf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbVEFMUf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 08:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261189AbVEFMUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 08:20:35 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:18446 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261183AbVEFMUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 08:20:31 -0400
To: dedekind@infradead.org
CC: akpm@osdl.org, dwmw2@infradead.org, wli@holomorphy.com,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <1115381679.27158.23.camel@sauron.oktetlabs.ru>
	(dedekind@infradead.org)
Subject: Re: [PATCH] __wait_on_freeing_inode fix
References: <E1DU1Hy-00060Q-00@dorka.pomaz.szeredi.hu> <1115381679.27158.23.camel@sauron.oktetlabs.ru>
Message-Id: <E1DU1o1-00063l-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 06 May 2005 14:19:45 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > This patch fixes queer behavior in __wait_on_freeing_inode().
> Although the patch looks sane & simple, I gonna test your patch today.
> I'll report the results. 

Thanks!

Miklos
