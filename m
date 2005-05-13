Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262444AbVEMRTS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262444AbVEMRTS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 13:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262445AbVEMRTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 13:19:18 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:44816 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262444AbVEMRSQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 13:18:16 -0400
To: viro@parcelfarce.linux.theplanet.co.uk
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <20050513170602.GI1150@parcelfarce.linux.theplanet.co.uk>
	(message from Al Viro on Fri, 13 May 2005 18:06:02 +0100)
Subject: Re: [PATCH] namespace.c: fix bind mount from foreign namespace
References: <E1DWXeF-00017l-00@dorka.pomaz.szeredi.hu> <20050513170602.GI1150@parcelfarce.linux.theplanet.co.uk>
Message-Id: <E1DWdn9-0004O2-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 13 May 2005 19:17:39 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Bind mount from a foreign namespace results in
> 
> ... -EINVAL

Wrong answer.  Look again, you wrote the code, so you _should_ know ;)

Miklos
