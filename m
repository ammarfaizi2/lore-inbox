Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267661AbTACU5N>; Fri, 3 Jan 2003 15:57:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267662AbTACU5N>; Fri, 3 Jan 2003 15:57:13 -0500
Received: from jive.SoftHome.net ([66.54.152.27]:23194 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id <S267661AbTACU5I>;
	Fri, 3 Jan 2003 15:57:08 -0500
Subject: Re: [2.5.54] OOPS: unable to handle kernel paging request
From: Steven Barnhart <sbarn03@softhome.net>
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0301031046100.25684-100000@coffee.psychology.mcmaster.ca>
References: <Pine.LNX.4.44.0301031046100.25684-100000@coffee.psychology.mcmaster.ca>
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Jan 2003 16:05:53 -0500
Message-Id: <1041627959.1862.2.camel@sbarn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-01-03 at 10:48, Mark Hahn wrote:
> it's not very meaningful: some part of the kernel tried dereferencing
> a null pointer (as it happens, with a negative offset, such as you might
> expect from a variable sitting in the stack).
> the negativeness is not surprising, and the value of the offset would
> depend on your cpu/compiler/config.

Well I have a Intel Celeron 1.06 GHz (i686). 384MB ram, gcc 3.2 (redhat
8 release). I don't really know how to decode it since I have no serial
console hookups...anything paticualr I could get from the oops report
during bootup? i.e. what sections to copy?

-- 
Steven
sbarn03@softhome.net
GnuPG Fingerprint: 9357 F403 B0A1 E18D 86D5  2230 BB92 6D64 D516 0A94

