Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932463AbWEWXU2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932463AbWEWXU2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 19:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932472AbWEWXU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 19:20:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40680 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932463AbWEWXU2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 19:20:28 -0400
Date: Tue, 23 May 2006 16:20:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc4-mm3: scary warning from pdflush
Message-Id: <20060523162005.12c1e5c7.akpm@osdl.org>
In-Reply-To: <20060523223515.GA1571@elf.ucw.cz>
References: <20060523223515.GA1571@elf.ucw.cz>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
> 
> Not sure, I'm getting this during resume:
> 
> May 24 00:34:01 amd kernel: Restarting tasks...pdflush: bogus wakeup!
> May 24 00:34:01 amd kernel:  done
> May 24 00:34:01 amd kernel: Thawing cpus ...
> 
> Is it expected?

It is expected if you expect me to screw stuff up.  I fixed it locally,
thanks.

