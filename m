Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289036AbSAFVJL>; Sun, 6 Jan 2002 16:09:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289035AbSAFVJB>; Sun, 6 Jan 2002 16:09:01 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:58787 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S289033AbSAFVIt>; Sun, 6 Jan 2002 16:08:49 -0500
Date: Sun, 6 Jan 2002 14:08:47 -0700
Message-Id: <200201062108.g06L8lM17189@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Matt Dainty <matt@bodgit-n-scarper.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] DevFS support for /dev/cpu/X/(cpuid|msr)
In-Reply-To: <3C38BC6B.7090301@zytor.com>
In-Reply-To: <20020106181749.A714@butterlicious.bodgit-n-scarper.com>
	<200201061934.g06JYnZ15633@vindaloo.ras.ucalgary.ca>
	<3C38BC6B.7090301@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin writes:
> Once again, this shit does not belong in N drivers; it is core code.

Drivers have to register their own device nodes. What kind of API do
you propose?

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
