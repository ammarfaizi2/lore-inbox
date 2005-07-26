Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261776AbVGZGeI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261776AbVGZGeI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 02:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261793AbVGZGb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 02:31:57 -0400
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:58358 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S261783AbVGZG3q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 02:29:46 -0400
Date: Tue, 26 Jul 2005 08:29:39 +0200
From: Voluspa <lista1@telia.com>
To: len.brown@intel.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3 Battery times at 100/250/1000 Hz = Zero difference
Message-Id: <20050726082939.2a7388cd.lista1@telia.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2005-07-26 5:23:08 Len Brown wrote:

>than C1 and the generic ACPI code doesn't support it,
>then it is either a Linux/ACPI bug or a BIOS bug -- file away:-)

The issue has made me fume enough to contemplating installing windos for
the first time in some 10 years. But I'll persevere. Will learn
ACPI-speak, read bios- and kernelcode. Then return, have no fear (even
if just to admit that the BIOS is buggy). Speaking of bugs, I was
directed, off-list, to the patch which mends your latest chip-away of
C2/C3 for many systems:

http://marc.theaimsgroup.com/?l=acpi4linux&m=112138186129178&w=2

It did however not fix my K8 system.

>I.e. The whole concept of ACPI is that you shoulud _not_ need
>a platform specific driver to accomplish this.

Indeed. It's supposed to be some kind of neutral non-discrimatory
standard... I suppose.

Mvh
Mats Johannesson
--
