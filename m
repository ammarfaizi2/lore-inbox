Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292612AbSBVCuF>; Thu, 21 Feb 2002 21:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292609AbSBVCt6>; Thu, 21 Feb 2002 21:49:58 -0500
Received: from ns.suse.de ([213.95.15.193]:57874 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S292613AbSBVCtm>;
	Thu, 21 Feb 2002 21:49:42 -0500
Date: Fri, 22 Feb 2002 03:49:38 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Brett <brett@bad-sports.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.5-dj1 - ide_set_handler/kernel timer
In-Reply-To: <Pine.LNX.4.44.0202221314280.7163-100000@bad-sports.com>
Message-ID: <Pine.LNX.4.33.0202220348540.14170-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Feb 2002, Brett wrote:

> This just popped up a few minutes after boot:
> hda: ide_set_handler: handler not null; old=c01c4d30, new=c01c4d30
> bug: kernel timer added twice at c01c6197.

Argh, I thought things would be less problematic by dropping
those ide changes.   Looks like I missed something.
I'll take a look in the morning.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

