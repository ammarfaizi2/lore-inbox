Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbUCHVZu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 16:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbUCHVZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 16:25:50 -0500
Received: from 75.80-203-232.nextgentel.com ([80.203.232.75]:7142 "EHLO
	lincoln.jordet.nu") by vger.kernel.org with ESMTP id S261246AbUCHVZt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 16:25:49 -0500
Subject: Re: smbfs patch
From: Stian Jordet <liste@jordet.nu>
To: =?ISO-8859-1?Q?S=F8ren?= Hansen <sh@warma.dk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1078438839.10042.6.camel@luke>
References: <1078438839.10042.6.camel@luke>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1078781118.4013.1.camel@buick.jordet>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 08 Mar 2004 22:25:18 +0100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tor, 04.03.2004 kl. 23.20 skrev Søren Hansen:
> I noticed that smbfs no longer respects the "uid" and "gid" mount
> options passed to it by mount.(I think it stopped when the server was
> upgraded to Samba 3.0. Not sure though, since my client was upgraded to
> Linux 2.6.3 at around the same time). I've made this small patch that
> fixes it (bear with me, this is my first patch to the kernel :-)  ):

I have the same problem as you have. I have not gotten around to test
your patch yet (but will later tonight), but I read in another mail from
you that you had discussed the patch with Urban Widmark. Is the any
opinions against this patch? If not, will you try to submit it to
Andrew/Linus?

Anyway, thanks for the patch :)

Best regards,
Stian

