Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270547AbUJTWlx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270547AbUJTWlx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 18:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270562AbUJTWhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 18:37:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:43677 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270547AbUJTWhd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 18:37:33 -0400
Date: Wed, 20 Oct 2004 15:41:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Martin Waitz <tali@admingilde.org>
Cc: jdike@karaya.com, linux-kernel@vger.kernel.org,
       "blaisorblade_spam@yahoo.it" <blaisorblade_spam@yahoo.it>
Subject: Re: generic hardirq handling for uml
Message-Id: <20041020154105.7baa5166.akpm@osdl.org>
In-Reply-To: <20041020001124.GA29215@admingilde.org>
References: <20041020001124.GA29215@admingilde.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Waitz <tali@admingilde.org> wrote:
>
> I just ported arch/um to generic hardirq handling.

OK, I'll add this to 2.6.9-mm1 (which appears to be a few days off yet).  If
nobody complains, it goes in.  Thanks.
