Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262169AbUKQCXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262169AbUKQCXn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 21:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262165AbUKQCXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 21:23:43 -0500
Received: from fw.osdl.org ([65.172.181.6]:18317 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262162AbUKQCWq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 21:22:46 -0500
Date: Tue, 16 Nov 2004 18:22:33 -0800
From: Andrew Morton <akpm@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc2-mm1
Message-Id: <20041116182233.097d9d85.akpm@osdl.org>
In-Reply-To: <1100640653.16765.0.camel@krustophenia.net>
References: <20041116014213.2128aca9.akpm@osdl.org>
	<1100640653.16765.0.camel@krustophenia.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> wrote:
>
>  On Tue, 2004-11-16 at 01:42 -0800, Andrew Morton wrote:
>  > http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.10-rc2-mm1.gz
>  > 
> 
>  Why was the VIA DRM removed?  It was in 2.6.9-mm1 but seems to be gone
>  now.

Actually I haven't been updating that for a while, because of ghastly
conflicts upstream.  Then it disappeared altogether due to administrative
error.

I'll see if I can resurrect it.
