Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265613AbUFDFUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265613AbUFDFUV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 01:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265614AbUFDFUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 01:20:21 -0400
Received: from gprs187-64.eurotel.cz ([160.218.187.64]:1920 "EHLO
	midnight.ucw.cz") by vger.kernel.org with ESMTP id S265613AbUFDFUR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 01:20:17 -0400
Date: Fri, 4 Jun 2004 07:18:41 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc2-mm1
Message-ID: <20040604051841.GA1081@ucw.cz>
References: <20040601021539.413a7ad7.akpm@osdl.org> <20040602132654.GY2093@holomorphy.com> <20040603233828.GA27504@kroah.com> <20040604000718.GP21007@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040604000718.GP21007@holomorphy.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2004 at 05:07:18PM -0700, William Lee Irwin III wrote:
> On Wed, Jun 02, 2004 at 06:26:54AM -0700, William Lee Irwin III wrote:
> >> Fix warnings about various structs declared inside parameter lists and so
> >> on seen while compiling compat_ioctl.c.
> 
> On Thu, Jun 03, 2004 at 04:38:28PM -0700, Greg KH wrote:
> > Doesn't apply to my, or a clean -rc2 tree :(
> > Probably needs to be sent to Vojtech and put in his tree.
> > thanks,
> > greg k-h
> 
> Vojtech, gregkh referred me to you for this change. Some compilation
> failures are caused by some changes to hiddev.h or some surrounding
> area in -mm; this patch resolves them.
> 
> Thanks.

Thanks, applied.


-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
