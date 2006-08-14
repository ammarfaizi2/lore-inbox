Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965050AbWHNXOk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965050AbWHNXOk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 19:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965054AbWHNXOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 19:14:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9368 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965050AbWHNXOh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 19:14:37 -0400
Date: Mon, 14 Aug 2006 16:14:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Denis Vlasenko <vda.linux@googlemail.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] aic7xxx: remove excessive inlining
Message-Id: <20060814161434.d643f568.akpm@osdl.org>
In-Reply-To: <200608131457.21951.vda.linux@googlemail.com>
References: <200608131457.21951.vda.linux@googlemail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Aug 2006 14:57:21 +0200
Denis Vlasenko <vda.linux@googlemail.com> wrote:

> This is a resend.

Please resend ;)

- All these patches had the same Subject:, thus forcing me to invent
  titles for you.  

- The changelogs are weird - think what they'll look like once they hit
  the git tree.  Someone will need to clean those changelogs up, and I'd
  prefer that it not be me.

- Missing Signed-off-by:'s.

http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt is here to help.

Thanks.
