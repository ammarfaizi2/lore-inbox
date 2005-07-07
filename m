Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261302AbVGGLjI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261302AbVGGLjI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 07:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbVGGLgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 07:36:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15852 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261302AbVGGLfU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 07:35:20 -0400
Date: Thu, 7 Jul 2005 04:34:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc2-mm1
Message-Id: <20050707043436.0f17a6e7.akpm@osdl.org>
In-Reply-To: <E1DqUWy-0002hC-00@dorka.pomaz.szeredi.hu>
References: <20050707040037.04366e4e.akpm@osdl.org>
	<E1DqUWy-0002hC-00@dorka.pomaz.szeredi.hu>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> > - Anything which you think needs to go into 2.6.13, please let me know.
> 
>  FUSE?

I'm inclined to just give up on the permissions thing - if someone comes up
with something better then fine.

But I do wonder whether v9fs would be a better place to be concentrating
the development effort.

