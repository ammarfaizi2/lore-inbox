Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbTEQKEA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 06:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbTEQKEA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 06:04:00 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:40975 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S261365AbTEQKD7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 06:03:59 -0400
Date: Sat, 17 May 2003 03:18:40 -0700
From: Andrew Morton <akpm@digeo.com>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: c-d.hailfinger.kernel.2003@gmx.net, rmk@arm.linux.org.uk,
       linux-kernel@vger.kernel.org, davej@suse.de
Subject: Re: 2.5.69-mm6: pccard oops while booting: round 2
Message-Id: <20030517031840.486683fc.akpm@digeo.com>
In-Reply-To: <1053166275.586.9.camel@teapot.felipe-alfaro.com>
References: <1052964213.586.3.camel@teapot.felipe-alfaro.com>
	<20030514191735.6fe0998c.akpm@digeo.com>
	<1052998601.726.1.camel@teapot.felipe-alfaro.com>
	<20030515130019.B30619@flint.arm.linux.org.uk>
	<1053004615.586.2.camel@teapot.felipe-alfaro.com>
	<20030515144439.A31491@flint.arm.linux.org.uk>
	<1053037915.569.2.camel@teapot.felipe-alfaro.com>
	<20030515160015.5dfea63f.akpm@digeo.com>
	<1053090184.653.0.camel@teapot.felipe-alfaro.com>
	<1053110098.648.1.camel@teapot.felipe-alfaro.com>
	<20030516132908.62e54266.akpm@digeo.com>
	<1053121346.569.1.camel@teapot.felipe-alfaro.com>
	<3EC56173.1000306@gmx.net>
	<1053166275.586.9.camel@teapot.felipe-alfaro.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 May 2003 10:16:48.0369 (UTC) FILETIME=[6D0E3610:01C31C5D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> wrote:
>
> "oops" contains the kernel oops when booting 2.5.69-mm6 + ymfpci2.patch
>  using the above config file.

Bummer.  Vital info is chopped off the top of the oops output.
