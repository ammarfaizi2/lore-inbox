Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261374AbTEAP3h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 11:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261387AbTEAP3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 11:29:37 -0400
Received: from h-66-134-11-58.CHCGILGM.covad.net ([66.134.11.58]:10257 "EHLO
	miniborg.vocalabs.com") by vger.kernel.org with ESMTP
	id S261374AbTEAP3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 11:29:34 -0400
Date: Thu, 1 May 2003 06:41:30 -0400 (EDT)
From: Daniel Taylor <dtaylor@vocalabs.com>
To: Dave Jones <davej@codemonkey.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Boot failure, VIA chipset.
In-Reply-To: <20030501153249.GA19001@suse.de>
Message-ID: <Pine.LNX.4.44.0305010638360.1739-100000@dante.vocalabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 May 2003, Dave Jones wrote:

> On Thu, May 01, 2003 at 05:53:53AM -0400, Daniel Taylor wrote:
>  > > CONFIG_INPUT=y
>  > > CONFIG_VT=y
>  > > CONFIG_VT_CONSOLE=y
>  > >
>  > All enabled, and I tried last night with a stripped down 386 only kernel.
>  >
>  > No dice, dies hard even before printing the Kernel ID.
>  >
>  > It is probably a BIOS compatability issue, but it works OK with 2.4. Since
>  > the system actually works as it sits I've been taking my time debugging
>  > the 2.5 issues.
>
> The only other outstanding hang that I've seen was caused by ACPI.
> Does it boot with acpi=off ?
>
That was the _first_ thing I tried. I've got it stripped down almost
to driverless (I still have IDE and filesystems compiled in). No advanced
options selected at all as far as I can find.

-- 
Daniel Taylor        VP Operations and Development   Vocal Laboratories, Inc.
dtaylor@vocalabs.com   http://www.vocalabs.com/        (952)941-6580x203

