Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263037AbUEFVY4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263037AbUEFVY4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 17:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263062AbUEFVY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 17:24:56 -0400
Received: from fw.osdl.org ([65.172.181.6]:54410 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263037AbUEFVYy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 17:24:54 -0400
Date: Thu, 6 May 2004 14:23:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: torvalds@osdl.org, pazke@donpac.ru, linux-kernel@vger.kernel.org,
       airlied@linux.ie
Subject: Re: [RFC] DMI cleanup patches
Message-Id: <20040506142304.3f0212be.akpm@osdl.org>
In-Reply-To: <20040506163206.GB8430@redhat.com>
References: <20040506102904.GA3295@pazke>
	<Pine.LNX.4.58.0405060738430.3271@ppc970.osdl.org>
	<20040506081012.6cb4ab2f.akpm@osdl.org>
	<20040506163206.GB8430@redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> wrote:
>
> On Thu, May 06, 2004 at 08:10:12AM -0700, Andrew Morton wrote:
> 
>  > There is a significant amount of work pending in the DRM development tree
>  > at http://drm.bkbits.net/drm-2.6 (which is included in -mm).  Andrey's
>  > zeroeth patch alone tosses three rejects against it.
> 
> Why on earth is the DRM stuff touching the DMI code ?
> 

Please note the relevant header on my email:

	Date: Thu, 6 May 2004 08:10:12 -0700

Having now had a corrective nap I can confirm that

a) I'm a twit and
b) there are still a ton of rejects against Linus's tree.

Andrey, please update and resend.
