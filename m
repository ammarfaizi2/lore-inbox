Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130032AbQLINWw>; Sat, 9 Dec 2000 08:22:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131125AbQLINWm>; Sat, 9 Dec 2000 08:22:42 -0500
Received: from hera.cwi.nl ([192.16.191.1]:38909 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S130032AbQLINWg>;
	Sat, 9 Dec 2000 08:22:36 -0500
Date: Sat, 9 Dec 2000 13:52:08 +0100
From: Andries Brouwer <aeb@veritas.com>
To: Matan Ziv-Av <matan@svgalib.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Big IDE HD unclipping and IBM drive [solved]
Message-ID: <20001209135208.A839@veritas.com>
In-Reply-To: <Pine.LNX.4.21_heb2.09.0012082319530.962-100000@matan.home> <Pine.LNX.4.21_heb2.09.0012091138590.631-100000@matan.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.21_heb2.09.0012091138590.631-100000@matan.home>; from matan@svgalib.org on Sat, Dec 09, 2000 at 11:50:59AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 09, 2000 at 11:50:59AM +0200, Matan Ziv-Av wrote:

> I use the attached program, which is a modification of setmax,

Good! So we learned something again.
I merged both versions of setmax.c and added text to the
Large Disk HOWTO. See
	http://www.win.tue.nl/~aeb/linux/Large-Disk-11.html#ss11.3

Comments are welcome.

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
