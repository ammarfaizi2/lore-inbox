Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130421AbRBCVLW>; Sat, 3 Feb 2001 16:11:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130727AbRBCVLN>; Sat, 3 Feb 2001 16:11:13 -0500
Received: from mailhost.tue.nl ([131.155.2.5]:2876 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S130421AbRBCVLA>;
	Sat, 3 Feb 2001 16:11:00 -0500
Message-ID: <20010203221057.A17106@win.tue.nl>
Date: Sat, 3 Feb 2001 22:10:57 +0100
From: Guest section DW <dwguest@win.tue.nl>
To: thunder7@xs4all.nl, linux-kernel@vger.kernel.org
Subject: Re: one of the most useless patches you'll ever see
In-Reply-To: <20010203173606.A7821@middle.of.nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20010203173606.A7821@middle.of.nowhere>; from thunder7@xs4all.nl on Sat, Feb 03, 2001 at 05:36:06PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 03, 2001 at 05:36:06PM +0100, thunder7@xs4all.nl wrote:

> This copies the sun 12x22 font to a 12x20 font.
> Readability on a 21" monitor remains very high @ 1600x1200, but you get
> 60 lines instead of 55.

Wouldnt it suffice to do
	setfont -h20 sun12x22
?

[With a setfont from kbd-1.04.]

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
