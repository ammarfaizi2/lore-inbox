Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262103AbVD1Hfr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262103AbVD1Hfr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 03:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbVD1Hfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 03:35:41 -0400
Received: from fire.osdl.org ([65.172.181.4]:49850 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262103AbVD1Hfa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 03:35:30 -0400
Date: Thu, 28 Apr 2005 00:34:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: dedekind@infradead.org
Cc: miklos@szeredi.hu, linux-kernel@vger.kernel.org, dwmw2@infradead.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] VFS bugfix: two read_inode() calles without
 clear_inode() call between
Message-Id: <20050428003450.51687b65.akpm@osdl.org>
In-Reply-To: <1114673528.3483.2.camel@sauron.oktetlabs.ru>
References: <1114607741.12617.4.camel@sauron.oktetlabs.ru>
	<E1DQoui-0002In-00@dorka.pomaz.szeredi.hu>
	<1114618748.12617.23.camel@sauron.oktetlabs.ru>
	<E1DQqZu-0002Rf-00@dorka.pomaz.szeredi.hu>
	<1114673528.3483.2.camel@sauron.oktetlabs.ru>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Artem B. Bityuckiy" <dedekind@infradead.org> wrote:
>
>  I assume I don't need to notify Andrew about the inconsistency in the
>  old patch, or should I?

Nope, just send the new patch.  Please be sure to include a complete and
up-to-date explanation of what it does, and why - I haven't looked at this
yet.

