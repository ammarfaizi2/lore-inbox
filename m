Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261703AbTCZONf>; Wed, 26 Mar 2003 09:13:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261705AbTCZONf>; Wed, 26 Mar 2003 09:13:35 -0500
Received: from 237.oncolt.com ([213.86.99.237]:62656 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S261703AbTCZONe>; Wed, 26 Mar 2003 09:13:34 -0500
Subject: Re: [patch] 2.4.21-pre5 kksymoops for i386/ia64
From: David Woodhouse <dwmw2@infradead.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
In-Reply-To: <24872.1048117135@ocs3.intra.ocs.com.au>
References: <24872.1048117135@ocs3.intra.ocs.com.au>
Content-Type: text/plain
Organization: 
Message-Id: <1048688679.12528.285.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4.dwmw2) 
Date: 26 Mar 2003 14:24:40 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-03-19 at 23:38, Keith Owens wrote:
> Bottom line - when, and only when, the kksymoops patch is in the 2.4
> kernel, then I will spend the time to make modutils 2.4 work in cross
> compile mode.  If you insist that kallsyms work in cross compile mode
> before the patch goes in, then it is not going to happen and nobody
> gets automatic oops decoding in 2.4.

I can understand your frustration, but you know perfectly well that
features which don't work for non-i386, don't work on SMP, or don't work
when cross-compiled just _don't_ get merged. (In general, at least).

-- 
dwmw2

