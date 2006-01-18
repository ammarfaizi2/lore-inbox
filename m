Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030432AbWARUlo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030432AbWARUlo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 15:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030431AbWARUln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 15:41:43 -0500
Received: from smtp.osdl.org ([65.172.181.4]:52121 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030432AbWARUlm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 15:41:42 -0500
Date: Wed, 18 Jan 2006 12:41:24 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1-mm1: Oops and BUG()
Message-Id: <20060118124124.2eb3761a.akpm@osdl.org>
In-Reply-To: <200601181610.16336.jesper.juhl@gmail.com>
References: <200601181610.16336.jesper.juhl@gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <jesper.juhl@gmail.com> wrote:
>
> Just got an Oops and BUG() with 2.6.16-rc1-mm1.
>

Yes, sorry, one of the reiserfs patch series obviously wasn't ready for
prime time.

