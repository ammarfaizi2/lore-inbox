Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276150AbRJKQJF>; Thu, 11 Oct 2001 12:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276233AbRJKQIz>; Thu, 11 Oct 2001 12:08:55 -0400
Received: from maestro.symsys.com ([208.223.9.37]:3589 "EHLO
	maestro.symsys.com") by vger.kernel.org with ESMTP
	id <S276150AbRJKQIs>; Thu, 11 Oct 2001 12:08:48 -0400
Date: Thu, 11 Oct 2001 11:09:19 -0500 (CDT)
From: Greg Ingram <ingram@symsys.com>
To: linux-kernel@vger.kernel.org
Subject: Sound on Vaio partially dies between 2.4.5 and 2.4.6
In-Reply-To: <Pine.SOL.4.33.0110111645410.18253-100000@yellow.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.21.0110111101001.26548-100000@maestro.symsys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Gentlemen,

I have a Sony Vaio PCG-FX215 and use via82cxxx_audio and ac97_codec as
modules to drive the sound.  With all kernel versions I can play 8-bit
ISDN u-law files.  With 2.4.5 and earlier (back to 2.2.19presomething at
least) I could play MP3s.  With 2.4.6 and later I get a "No supported rate
found!" message from mpg123 (version 0.59q).  The particular MP3 is
encoded at 128 kbit/s, 44100 Hz joint stereo.

Regards,

- Greg


