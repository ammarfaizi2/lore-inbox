Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265346AbUAAJpQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 04:45:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265352AbUAAJpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 04:45:15 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:33288 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S265346AbUAAJpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 04:45:13 -0500
Date: Thu, 1 Jan 2004 10:44:50 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Henti Smith <henti@geekware.co.za>
Cc: azarah@nosferatu.za.org,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       mmastrac@canada.com
Subject: Re: error message in dmesg
Message-ID: <20040101094450.GA3728@alpha.home.local>
References: <20040101052029.40b10f87.henti@geekware.co.za> <1072928707.7243.20.camel@nosferatu.lan> <20040101055355.57a3ddf2.henti@geekware.co.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040101055355.57a3ddf2.henti@geekware.co.za>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 01, 2004 at 05:53:55AM +0200, Henti Smith wrote:
> <insert memory stick>
> mount /dev/sda1 /mnt/floppy/
> dd if=/dev/sda1 of=/dev/null count=10 bs=1024

and what happens if you unmount it here, before removing the stick ?

> <remove memory stick>
> dd if=/dev/sda1 of=/dev/null count=10 bs=1024

Willy

