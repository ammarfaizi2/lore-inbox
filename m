Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275093AbTHQJYp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 05:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275094AbTHQJYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 05:24:45 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:738
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S275093AbTHQJYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 05:24:44 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] O16.2int
Date: Sun, 17 Aug 2003 19:30:51 +1000
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <200308161902.52337.kernel@kolivas.org> <20030817004013.14c399da.akpm@osdl.org>
In-Reply-To: <20030817004013.14c399da.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308171930.51621.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Aug 2003 17:40, Andrew Morton wrote:
> Con Kolivas <kernel@kolivas.org> wrote:
> > Much simpler
>
> But broken.
>
> The machine runs about 100x slower than normal.  The screensaver cut in
> halfway through the initscripts ;) That's on 2-way.  The same kernel works
> OK on uniprocessor.

Good enough. Don't worry about any of the 16s; this drastic change only helped 
the mild case anyway. I'll save only the cleanups and post an incremental to 
16.2 at a later stage.

Con

