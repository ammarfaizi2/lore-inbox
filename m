Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262823AbUDPIxZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 04:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262770AbUDPIxZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 04:53:25 -0400
Received: from witte.sonytel.be ([80.88.33.193]:57250 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262823AbUDPIxV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 04:53:21 -0400
Date: Fri, 16 Apr 2004 10:53:15 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Guennadi Liakhovetski <gl@dsa-ac.de>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Capitals in kernel directory-names
In-Reply-To: <Pine.LNX.4.33.0404161029380.1869-100000@pcgl.dsa-ac.de>
Message-ID: <Pine.GSO.4.58.0404161052220.20787@waterleaf.sonytel.be>
References: <Pine.LNX.4.33.0404161029380.1869-100000@pcgl.dsa-ac.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Apr 2004, Guennadi Liakhovetski wrote:
> Which drives to a conclusion, that generally kernel-developers
> (rightfully) dislike capital letters in file- and, even more so, in
> directory-names. And the only directories named with capitals are some
> arch-specifics, and Documentation. Well, was the latter named so to avoid
> using the doc(umentation) pattern?:-)

Files and directories that start with capitals show up first when using `ls',
that's why people use e.g. README, INSTALL, and Documentation.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
