Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932115AbWDFO1l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbWDFO1l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 10:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932120AbWDFO1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 10:27:40 -0400
Received: from sorrow.cyrius.com ([65.19.161.204]:10501 "EHLO
	sorrow.cyrius.com") by vger.kernel.org with ESMTP id S932115AbWDFO1k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 10:27:40 -0400
Date: Thu, 6 Apr 2006 15:27:28 +0100
From: Martin Michlmayr <tbm@cyrius.com>
To: schierlm@gmx.de, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.17-rc1
Message-ID: <20060406142727.GA22724@unjust.cyrius.com>
References: <Pine.LNX.4.64.0604022037380.3781@g5.osdl.org> <e0r09j$gu5$1@sea.gmane.org> <20060403194727.GD5616@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060403194727.GD5616@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Russell King <rmk+lkml@arm.linux.org.uk> [2006-04-03 20:47]:
> > kernel/built-in.o:(.data+0x758): undefined reference to `uevent_helper'
> > make: *** [.tmp_vmlinux1] Error 1
> 
> I've reported this bug several times but I seem to be getting absolutely
> no response.  So I submitted it to bugzilla.
> http://bugzilla.kernel.org/show_bug.cgi?id=6306
> 
> Feel free to add your voice to that bug to try to get someone to fix it.
> I'm not hopeful though.

Kay Sievers has added a patch to Bugzilla a few days ago.  Can you
confirm that it works?
-- 
Martin Michlmayr
tbm@cyrius.com
