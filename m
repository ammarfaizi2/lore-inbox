Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267472AbTBNWwh>; Fri, 14 Feb 2003 17:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267485AbTBNWwh>; Fri, 14 Feb 2003 17:52:37 -0500
Received: from fmr02.intel.com ([192.55.52.25]:59881 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S267472AbTBNWwg>; Fri, 14 Feb 2003 17:52:36 -0500
Subject: Re: WBEM and WMI
From: Rusty Lynch <rusty@linux.co.intel.com>
To: "Simoneaux, Jill" <jill.simoneaux@intel.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <B34A7DC9C1CDAB4D9A4BC2C0F15A06E83ACA99@fmsmsx401.fm.intel.com>
References: <B34A7DC9C1CDAB4D9A4BC2C0F15A06E83ACA99@fmsmsx401.fm.intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 14 Feb 2003 14:52:22 -0800
Message-Id: <1045263143.13489.24.camel@vmhack>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-02-14 at 14:54, Simoneaux, Jill wrote:
> Are there any plans for incorporating WBEM into the kernel??
> 
> J. Jill Simoneaux
> Integration Systems Engineering
> (916) 356-4628
> I don't speak for Intel
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

It is a general rule on Linux that as much functionality as possible is
pushed to user space.  Is there a specific feature needed to implement
WBEM that can only be supplied by the kernel?

    --rustyl



