Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263738AbTDGX6p (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 19:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263723AbTDGX6l (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 19:58:41 -0400
Received: from moutng.kundenserver.de ([212.227.126.183]:53715 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S263738AbTDGX5T (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 19:57:19 -0400
From: Martin Aumueller <ma@reserv.at>
Date: Tue, 8 Apr 2003 02:02:47 +0200
To: linux-kernel@kernel.org
Subject: Re: DMA Timeouts with 3112 SATA Controller (status == 0x21)
Message-ID: <20030408000247.GA2299@puma.reserv.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16016.56340.492697.198504@horse.como>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi *,

On Saturday I tried a Seagate 120GiB SATA with my onboard SiI3112 on
my ASUS P4G8X (with an Intel 7205 chipset). I suppose that David is
using a similiar setup with an 7505 chipset? Perhaps the problem is
somehow related to this chipset: I saw the exact same errors as David.
I also tried several kernels: 2.4.20-ac2, 2.4.20-pre5-ac3, 2.4.20-pre7,
2.5.66, 2.4.20-8 from Redhat 9, ... with exactly the same result.

Martin

