Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265993AbUA1PHT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 10:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265995AbUA1PHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 10:07:19 -0500
Received: from smtp1.adl2.internode.on.net ([203.16.214.181]:54532 "EHLO
	smtp1.adl2.internode.on.net") by vger.kernel.org with ESMTP
	id S265993AbUA1PHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 10:07:13 -0500
Subject: Re: 2.6.2-rc2-mm1
From: Antony Suter <suterant@users.sourceforge.net>
To: linux-kernel@vger.kernel.org
Cc: suterant@users.sourceforge.net
Content-Type: text/plain
Message-Id: <1075302403.10057.5.camel@hikaru.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 29 Jan 2004 02:06:43 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 27, 2004 at 11:34:02PM -0800, Andrew Morton wrote:
>
>
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.2-rc2/2.6.2-rc2-mm1/
>
>
> - From now on, -mm kernels will contain the latest contents of:
>
> Linus's tree: linus.patch
> The ACPI tree: acpi.patch
> Vojtech's tree: input.patch
> Jeff's tree: netdev.patch
> The ALSA tree: alsa.patch
>
> If anyone has any more external trees which need similar treatment,
> please let me know.
> 

The WLI patchset. It has a small number of good improvements for NUMA
machines and notebooks. A couple of the patches have already made it
into the kernel.

-- 
- Antony Suter  (suterant users sourceforge net)  "Bonta"
- "Huh, upgrades."

