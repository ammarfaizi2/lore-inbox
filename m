Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261948AbULGVwA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261948AbULGVwA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 16:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261949AbULGVwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 16:52:00 -0500
Received: from fw.osdl.org ([65.172.181.6]:36505 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261948AbULGVv6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 16:51:58 -0500
Date: Tue, 7 Dec 2004 13:55:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: Michael Hunold <hunold@linuxtv.org>
Cc: kraxel@bytesex.org, eyal@eyal.emu.id.au, hunold@convergence.de,
       torvalds@osdl.org, linux-kernel@vger.kernel.org, js@convergence.de
Subject: Re: Linux 2.6.10-rc3 oops when 'modprobe -r dvb-bt8xx'
Message-Id: <20041207135521.4c04c102.akpm@osdl.org>
In-Reply-To: <41B613E1.2010602@linuxtv.org>
References: <Pine.LNX.4.58.0412031611460.22796@ppc970.osdl.org>
	<41B1BD24.4050603@eyal.emu.id.au>
	<87653ex9wy.fsf@bytesex.org>
	<41B613E1.2010602@linuxtv.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Hunold <hunold@linuxtv.org> wrote:
>
> I just spoke to Johannes and we agree with you, Gerd. The DVB changes 
> can and should be merged from -mm now. There is a fair chance that the 
> remaining issues with broken cards can be resolved before 2.6.10.

How much end-user testing has the new code had?  ie: are we confident that
the new code is presently more stable than the old code?

> The code is in a good shape and only some small patches are missing from 
> the LinuxTV.org CVS.
> 
> I can prepare a patch that fixes the support for some cards and other 
> minor improvements tomorrow.

Yup, please start working on those things.
