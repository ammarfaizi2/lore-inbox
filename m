Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932358AbVH3TGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358AbVH3TGl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 15:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932383AbVH3TGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 15:06:41 -0400
Received: from smtp-102-tuesday.noc.nerim.net ([62.4.17.102]:9478 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S932358AbVH3TGk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 15:06:40 -0400
Date: Tue, 30 Aug 2005 21:06:38 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Paul Jackson <pj@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Trailing comments in broken-out series file break quilt
Message-Id: <20050830210638.69d8918d.khali@linux-fr.org>
In-Reply-To: <20050829191516.4e5d9e0b.pj@sgi.com>
References: <20050829191516.4e5d9e0b.pj@sgi.com>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

> However the quilt command passes these additional terms to the patch
> command as additional arguments, confusing the heck out of patch,
> and generating an error message that confused the heck out of me.
> 
> Question - should I be asking Andrew not to comment this way, or
> should I be asking quilt to recognize a comment convention here?

You should simply be using an up-to-date version of quilt, namely
version 0.42, which supports Andrew-style comments in series files just
fine.

Thanks,
-- 
Jean Delvare
