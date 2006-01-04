Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965293AbWADWHH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965293AbWADWHH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 17:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965303AbWADWHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 17:07:06 -0500
Received: from xenotime.net ([66.160.160.81]:60861 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S965293AbWADWHE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 17:07:04 -0500
Date: Wed, 4 Jan 2006 14:07:01 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: "John L. Villalovos" <john.l.villalovos@intel.com>
cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au, torvalds@osdl.org
Subject: Re: [PATCH] MAINTAINERS file: Fix missing colon
In-Reply-To: <43BC45DE.5060303@intel.com>
Message-ID: <Pine.LNX.4.58.0601041406210.19134@shark.he.net>
References: <43BC45DE.5060303@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jan 2006, John L. Villalovos wrote:

> From: John L. Villalovos <john.l.villalovos@intel.com>
>
> While parsing the MAINTAINERS file I disovered one entry was missing a colon.
> This patch adds the one missing colon.
>
> ---
> diff -r 8441517e7e79 MAINTAINERS
> --- a/MAINTAINERS       Thu Jan  5 04:00:05 2006
> +++ b/MAINTAINERS       Wed Jan  4 13:49:27 2006
> @@ -681,7 +681,7 @@
>
>   DAC960 RAID CONTROLLER DRIVER
>   P:     Dave Olien
> -M      dmo@osdl.org
> +M:     dmo@osdl.org
>   W:     http://www.osdl.org/archive/dmo/DAC960
>   L:     linux-kernel@vger.kernel.org
>   S:     Maintained

That would be helpful except that Dave is no longer at OSDL
and is no longer maintaining that driver...

-- 
~Randy
