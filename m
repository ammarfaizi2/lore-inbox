Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131237AbQKRNpj>; Sat, 18 Nov 2000 08:45:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131817AbQKRNpa>; Sat, 18 Nov 2000 08:45:30 -0500
Received: from astrid2.nic.fr ([192.134.4.2]:37383 "EHLO astrid2.nic.fr")
	by vger.kernel.org with ESMTP id <S131237AbQKRNpZ>;
	Sat, 18 Nov 2000 08:45:25 -0500
Date: Sat, 18 Nov 2000 14:15:24 +0000
From: Francois romieu <romieu@ensta.fr>
To: Kaj-Michael Lang <milang@tal.org>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] swap=<device> kernel commandline
Message-ID: <20001118141524.A15214@nic.fr>
Reply-To: Francois romieu <romieu@ensta.fr>
In-Reply-To: <Pine.LNX.4.20.0011181342280.6391-200000@tori.tal.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.20.0011181342280.6391-200000@tori.tal.org>; from milang@tal.org on Sat, Nov 18, 2000 at 01:46:40PM +0200
X-Organisation: Marie's fan club - I
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The Sat, Nov 18, 2000 at 01:46:40PM +0200, Kaj-Michael Lang wrote :
> This patch adds a swap kernel commandline option, so that you can add a
> swap partition before init starts running on a low-memory machine. 

Did you try and add swap from an initrd image ? It should work and it's
already there.

-- 
Ueimor
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
