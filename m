Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288717AbSADSfg>; Fri, 4 Jan 2002 13:35:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288716AbSADSf0>; Fri, 4 Jan 2002 13:35:26 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12548 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S288721AbSADSfL>;
	Fri, 4 Jan 2002 13:35:11 -0500
Message-ID: <3C35F5DA.61A57A3E@mandrakesoft.com>
Date: Fri, 04 Jan 2002 13:35:06 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: Dave Jones <davej@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: PATCH 2.5.2.7: io.h cleanup and userspace nudge
In-Reply-To: <Pine.LNX.4.33.0201041916490.20620-100000@Appserv.suse.de>
		<3C35F290.140BB2C7@mandrakesoft.com> <200201041831.g04IVAD23320@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch wrote:
> Please test this change on a libc5 system before unleashing a
> potential horror. All the world *is not* glibc!

(1) This is a devel series, the time for such changes, and (2) and it's
easy enough for libc5 systems to include their own sanitized copy of
kernel headers just like MDK, RHAT, and others are doing now for glibc.

	Jeff



-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno
