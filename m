Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317807AbSFMTYG>; Thu, 13 Jun 2002 15:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317803AbSFMTXe>; Thu, 13 Jun 2002 15:23:34 -0400
Received: from unet2-67.univie.ac.at ([131.130.232.67]:30348 "EHLO server.lan")
	by vger.kernel.org with ESMTP id <S317807AbSFMTWf>;
	Thu, 13 Jun 2002 15:22:35 -0400
From: Melchior FRANZ <a8603365@unet.univie.ac.at>
To: linux-kernel@vger.kernel.org
Subject: Re: Very large font size crashing X Font Server and Grounding Server to a Halt
Date: Thu, 13 Jun 2002 21:22:25 +0200
User-Agent: KMail/1.4.5
In-Reply-To: <200206131917.49235@pflug3.gphy.univie.ac.at> <20020613173422.B0D0D89@dps7.oconnoronline.net>
X-PGP: http://www.unet.univie.ac.at/~a8603365/melchior.franz
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200206132122.25981@pflug3.gphy.univie.ac.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Billy O'Connor -- Thursday 13 June 2002 19:34:
> This bit here, in Type1OpenScalable()?

This may be a different bug, though. In my case (requesting a particular
font at >=200 pt size) the Xserver always only aborted. While this is clearly
an unpleasant experience and has to be fixed, it never really =crashed=
or locked the machine.

m.  ??
