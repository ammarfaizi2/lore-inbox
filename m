Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270174AbRIHQ0a>; Sat, 8 Sep 2001 12:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270155AbRIHQ0U>; Sat, 8 Sep 2001 12:26:20 -0400
Received: from cs173101.pp.htv.fi ([213.243.173.101]:17270 "EHLO
	porkkala.cs173101.pp.htv.fi") by vger.kernel.org with ESMTP
	id <S270229AbRIHQ0I>; Sat, 8 Sep 2001 12:26:08 -0400
Message-ID: <3B9A468F.66C20011@pp.htv.fi>
Date: Sat, 08 Sep 2001 19:25:51 +0300
From: Jussi Laako <jlaako@pp.htv.fi>
X-Mailer: Mozilla 4.76 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Steven Spence <kwijibo@zianet.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: AMD 760 (761?) AGP
In-Reply-To: <3B97D334.E27BDA25@pp.htv.fi> <3B998088.6070206@zianet.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Spence wrote:
> 
> If you have it as a module try loading it with  agp_try_unsupported=1.
> If its not a module try appending it to lilo.  I have that chipset and
> everything works fine with those options.  I have a GF2U however not a 
> Radeon.  I can get 4x working with side band addressing and fast write.

Yes, I did try that and result is deadlock without video signal. Without AGP
it works fine. XFree86 and dri/drm driver is the latest CVS version.
(With or without dri enabled)

 - Jussi Laako

-- 
PGP key fingerprint: 161D 6FED 6A92 39E2 EB5B  39DD A4DE 63EB C216 1E4B
Available at PGP keyservers
