Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261875AbTC0KDB>; Thu, 27 Mar 2003 05:03:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261877AbTC0KDB>; Thu, 27 Mar 2003 05:03:01 -0500
Received: from delphin.mathe.tu-freiberg.de ([139.20.24.12]:35589 "EHLO
	delphin.mathe.tu-freiberg.de") by vger.kernel.org with ESMTP
	id <S261875AbTC0KDA> convert rfc822-to-8bit; Thu, 27 Mar 2003 05:03:00 -0500
From: Michael Dreher <dreher@math.tu-freiberg.de>
To: James Simmons <jsimmons@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Much better framebuffer fixes.
Date: Thu, 27 Mar 2003 11:16:45 +0100
User-Agent: KMail/1.5
References: <Pine.LNX.4.44.0303270017180.25001-100000@phoenix.infradead.org>
In-Reply-To: <Pine.LNX.4.44.0303270017180.25001-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200303271116.45373.dreher@math.tu-freiberg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Donnerstag, 27. März 2003 01:18 wrote James Simmons:
> Okay. Here are more framebuffer fixes. Please try these fixes and let
> me know how they work out for you.

Does not help. I still get a vertically splitted display under X if I
have

CONFIG_FB=y
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_VESA is not set
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_HGA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
CONFIG_FB_ATY128=y
# CONFIG_FB_ATY is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_VIRTUAL is not set


