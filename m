Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131436AbRABSpx>; Tue, 2 Jan 2001 13:45:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131371AbRABSpo>; Tue, 2 Jan 2001 13:45:44 -0500
Received: from p3EE3CA49.dip.t-dialin.net ([62.227.202.73]:12036 "HELO
	emma1.emma.line.org") by vger.kernel.org with SMTP
	id <S131005AbRABSpb>; Tue, 2 Jan 2001 13:45:31 -0500
Date: Tue, 2 Jan 2001 19:14:58 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Happy new year^H^H^H^Hkernel..
Message-ID: <20010102191458.B4299@emma1.emma.line.org>
Mail-Followup-To: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10012311205020.1210-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10012311205020.1210-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sun, Dec 31, 2000 at 12:24:44 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Dec 2000, Linus Torvalds wrote:

> Ok. I didn't make 2.4.0 in 2000. Tough. I tried, but we had some
> last-minute stuff that needed fixing (ie the dirty page lists etc), and
> the best I can do is make a prerelease.

I just compiled that one into a 1032 kB kernel, and it failed to be
booted from GRUB 0.5.95 (some CVS version). I then made USB into
modules, the kernel was 887 kB and booted. Is Linux 2.4 supposed to
suffer from the 1 M limit still?

-- 
Matthias Andree
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
