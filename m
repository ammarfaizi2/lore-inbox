Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261258AbVCGLaO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbVCGLaO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 06:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbVCGLaO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 06:30:14 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:33676 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261258AbVCGLaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 06:30:09 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: hugang@soulinfo.com
Subject: Re: [PATCH][3/3] swsusp: use non-contiguous memory
Date: Mon, 7 Mar 2005 12:32:31 +0100
User-Agent: KMail/1.7.1
Cc: Andrew Morton <akpm@zip.com.au>, LKML <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>
References: <200503042051.54176.rjw@sisk.pl> <20050307064131.GA31983@hugang.soulinfo.com>
In-Reply-To: <20050307064131.GA31983@hugang.soulinfo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503071232.32141.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 7 of March 2005 07:41, hugang@soulinfo.com wrote:
> On Fri, Mar 04, 2005 at 08:51:53PM +0100, Rafael J. Wysocki wrote:
> > From: Hu Gang <hugang@soulinfo.com>
> > 
> > Subject: swsusp: use non-contiguous memory on resume - ppc support
> > 
> > This patch contains the architecture-dependent changes for ppc
> > required for using a linklist instead of an array of page backup entries
> > during resume.
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
>   Signed-off-by: Hu Gang <hugang@soulinfo.com>

Yes, the Signed-off-by line was missing from the original patch.  Andrew,
should I resubmit it?

Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
