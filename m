Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315614AbSEIFD0>; Thu, 9 May 2002 01:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315615AbSEIFD0>; Thu, 9 May 2002 01:03:26 -0400
Received: from w007.z208177141.sjc-ca.dsl.cnc.net ([208.177.141.7]:55709 "HELO
	mail.gurulabs.com") by vger.kernel.org with SMTP id <S315614AbSEIFDZ>;
	Thu, 9 May 2002 01:03:25 -0400
Date: Wed, 8 May 2002 23:03:22 -0600 (MDT)
From: Dax Kelson <dax@gurulabs.com>
X-X-Sender: dkelson@mooru.gurulabs.com
To: P a v a n <pavankvk@indiatimes.com>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: cdp Strange behavior?
In-Reply-To: <200205090428.JAA05676@WS0005.indiatimes.com>
Message-ID: <Pine.LNX.4.44.0205082258310.11236-100000@mooru.gurulabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This isn't kernel related.  Since the early days of CDROM drives in 
computers, the "play audio" function is completely independent of the 
operating system. If the player app or the operating system doesn't tell 
the CDROM drive to stop, it will keep on playing irrespective if the 
operating system is even running.

The only exception is in the past ~3 years some players can do "Digital 
Audio Extraction" audio playing.  This does involve software, and is 
useful when you don't have the audio cable connected between your sound 
card and CDORM drive.

Dax Kelson

