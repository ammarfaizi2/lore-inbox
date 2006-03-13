Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932328AbWCMTbB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbWCMTbB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 14:31:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbWCMTbB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 14:31:01 -0500
Received: from xenotime.net ([66.160.160.81]:29158 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932328AbWCMTbA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 14:31:00 -0500
Date: Mon, 13 Mar 2006 11:32:44 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Doc/kernel-parameters.txt: delete false version
 information and history
Message-Id: <20060313113244.2c34f134.rdunlap@xenotime.net>
In-Reply-To: <tkrat.f6b9032d78fc1d70@s5r6.in-berlin.de>
References: <tkrat.f6b9032d78fc1d70@s5r6.in-berlin.de>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.2 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Mar 2006 20:21:09 +0100 (CET) Stefan Richter wrote:

> Doc/kernel-parameters.txt: delete false version information and history
> 
> Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>

Acked-by: Randy Dunlap <rdunlap@xenotime.net>


> --- linux/Documentation/kernel-parameters.txt.0	2006-03-13 19:28:13.000000000 +0100
> +++ linux/Documentation/kernel-parameters.txt	2006-03-13 19:32:28.000000000 +0100
> @@ -1,4 +1,4 @@
> -February 2003             Kernel Parameters                     v2.5.59
> +                          Kernel Parameters
>                            ~~~~~~~~~~~~~~~~~
>  
>  The following is a consolidated list of the kernel parameters as implemented
> @@ -1664,20 +1664,6 @@
>  
>  
>  ______________________________________________________________________
> -Changelog:
> -
> -2000-06-??	Mr. Unknown
> -	The last known update (for 2.4.0) - the changelog was not kept before.
> -
> -2002-11-24	Petr Baudis <pasky@ucw.cz>
> -		Randy Dunlap <randy.dunlap@verizon.net>
> -	Update for 2.5.49, description for most of the options introduced,
> -	references to other documentation (C files, READMEs, ..), added S390,
> -	PPC, SPARC, MTD, ALSA and OSS category. Minor corrections and
> -	reformatting.
> -
> -2005-10-19	Randy Dunlap <rdunlap@xenotime.net>
> -	Lots of typos, whitespace, some reformatting.
>  
>  TODO:


---
~Randy
You can't do anything without having to do something else first.
-- Belefant's Law
