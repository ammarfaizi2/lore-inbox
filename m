Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284833AbRLEXfS>; Wed, 5 Dec 2001 18:35:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284836AbRLEXfK>; Wed, 5 Dec 2001 18:35:10 -0500
Received: from front1.mail.megapathdsl.net ([66.80.60.31]:32015 "EHLO
	front1.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S284832AbRLEXfF>; Wed, 5 Dec 2001 18:35:05 -0500
Subject: Re: NVIDIA kernel module
From: Miles Lane <miles@megapathdsl.net>
To: Erik Elmore <lk@bigsexymo.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0112051719260.13083-100000@erik.bigsexymo.com>
In-Reply-To: <Pine.LNX.4.33.0112051719260.13083-100000@erik.bigsexymo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0+cvs.2001.12.04.08.57 (Preview Release)
Date: 05 Dec 2001 15:38:39 -0800
Message-Id: <1007595520.16919.4.camel@stomata.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2001-12-05 at 15:22, Erik Elmore wrote:
> Have I lost my mind?
> 
> I've always thought that NVIDIA's linux kernel support was incredibly 
> closed source, but I swear I just saw a download link for the kernel 
> module sources at http://www.nvidia.com/view.asp?PAGE=linux
> 
> was I mistaken or is this something new?

I think the kernel stuff is mostly just hooks into the kernel.
There isn't any significant proprietary information in the
kernel patch, unless I'm much mistaken.  The proprietary gold 
is hidden in the driver.

	Miles

