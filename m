Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262467AbVAJUsv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262467AbVAJUsv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 15:48:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262534AbVAJUoP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 15:44:15 -0500
Received: from adsl-298.mirage.euroweb.hu ([193.226.239.42]:57267 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262529AbVAJUnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 15:43:39 -0500
To: Brice.Goglin@ens-lyon.org
CC: akpm@osdl.org, torvalds@osdl.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-reply-to: <41E2E6D8.2070201@ens-lyon.fr> (message from Brice Goglin on Mon,
	10 Jan 2005 21:34:32 +0100)
Subject: Re: [PATCH 1/11] FUSE - MAINTAINERS, Kconfig and Makefile changes
References: <E1Co4iU-00043y-00@dorka.pomaz.szeredi.hu> <41E2E276.1070309@ens-lyon.fr> <E1Co6DZ-0004Kx-00@dorka.pomaz.szeredi.hu> <41E2E6D8.2070201@ens-lyon.fr>
Message-Id: <E1Co6Nk-0004ND-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 10 Jan 2005 21:43:20 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > It does.  CONFIG_ is prepended by make config.
> > 
> > Miklos
> 
> Yes, but _FS is not appended :) That was my concern.

Oh, in that case your comment is justified :)

Thanks,
Miklos
