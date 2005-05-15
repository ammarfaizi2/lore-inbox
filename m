Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261528AbVEOBbb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbVEOBbb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 21:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261534AbVEOBbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 21:31:31 -0400
Received: from fire.osdl.org ([65.172.181.4]:49068 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261528AbVEOBba (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 21:31:30 -0400
Date: Sat, 14 May 2005 18:30:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc4-mm1
Message-Id: <20050514183051.38f97256.akpm@osdl.org>
In-Reply-To: <20050515012051.GJ9304@holomorphy.com>
References: <20050512033100.017958f6.akpm@osdl.org>
	<20050515012051.GJ9304@holomorphy.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> On Thu, May 12, 2005 at 03:31:00AM -0700, Andrew Morton wrote:
>  > +uml-remove-elfh.patch
>  > +uml-critical-change-memcpy-to-memmove.patch
>  >  UML important updates
> 
>  uml-remove-elfh looks empty.

Yeah, I couldn't work out a way of generating a patch which removes a
zero-length file, so that's there as a reminder to ask Linus to remove the
thing by hand.

>  Anyway, the real patch, of minor importance, follows in an attachment.

OK..
