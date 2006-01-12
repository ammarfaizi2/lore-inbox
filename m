Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161329AbWALVzZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161329AbWALVzZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 16:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161332AbWALVzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 16:55:25 -0500
Received: from isilmar.linta.de ([213.239.214.66]:22145 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S1161329AbWALVzZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 16:55:25 -0500
Date: Thu, 12 Jan 2006 22:55:23 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>
Subject: Re: git status (was: drm tree for 2.6.16-rc1)
Message-ID: <20060112215523.GA19656@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
	linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>
References: <Pine.LNX.4.58.0601120948270.1552@skynet> <Pine.LNX.4.64.0601121016020.3535@g5.osdl.org> <20060112134255.29074831.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060112134255.29074831.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jan 12, 2006 at 01:42:55PM -0800, Andrew Morton wrote:
> 40442				git-pcmcia.patch

> pcmcia: had a problem but I think that's now fixed.  But this seems
>         to be fairly fresh code?

For the two important fixes which are part of this tree, (add new IDs for
serial_cs.c, runtime powermanagement interface), please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/brodo/pcmcia-fixes-2.6.git/


The other patches are indeed fresh code, and are meant for 2.6.17.

Thanks,
	Dominik
