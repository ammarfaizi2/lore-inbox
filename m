Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131018AbRCPT3P>; Fri, 16 Mar 2001 14:29:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130517AbRCPT2y>; Fri, 16 Mar 2001 14:28:54 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13323 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S130216AbRCPT2u>;
	Fri, 16 Mar 2001 14:28:50 -0500
Date: Fri, 16 Mar 2001 19:26:46 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Dawson Engler <engler@csl.Stanford.EDU>, linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] 9 potential copy_*_user bugs in 2.4.1
Message-ID: <20010316192646.A8755@flint.arm.linux.org.uk>
In-Reply-To: <200103160224.SAA03920@csl.Stanford.EDU> <1886.984737208@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1886.984737208@redhat.com>; from dwmw2@infradead.org on Fri, Mar 16, 2001 at 10:06:48AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2001 at 10:06:48AM +0000, David Woodhouse wrote:
> Nice work - thanks. One request though, to you and anyone else doing such
> cleanups - please could you list the affected files separately near the
> beginning of your mail, so that people can tell at a glance whether there's
> anything in there that might be their fault.

Also, it'd be nice if the filenames were in alphabetic order.  Both points
make it much easier to examine the list of affected files.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

