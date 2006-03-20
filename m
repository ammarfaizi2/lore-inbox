Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964804AbWCTO36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964804AbWCTO36 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 09:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964814AbWCTO36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 09:29:58 -0500
Received: from [81.2.110.250] ([81.2.110.250]:50832 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S964804AbWCTO35 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 09:29:57 -0500
Subject: Re: Lindent and coding style
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Li Yang-r58472 <LeoLi@freescale.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9FCDBA58F226D911B202000BDBAD4673054C311B@zch01exm40.ap.freescale.net>
References: <9FCDBA58F226D911B202000BDBAD4673054C311B@zch01exm40.ap.freescale.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 20 Mar 2006 14:36:44 +0000
Message-Id: <1142865404.20050.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-03-20 at 19:32 +0800, Li Yang-r58472 wrote:
> There is a lindent script in linux kernel source.  It breaks long
> lines, but uses space instead of tab as indentation.  However, the
> codingstyle document also from the kernel source indicates no space is
> allowed for indentation.  Is there a fix for this problem?  Or the
> result from lindent(space indentation) is actually allowed in kernel
> source?  Thanks.
> 

It should produce suitable output. Do you have examples of where it
produces space indentation and you expect tabs ?
