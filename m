Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267205AbUIORzX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267205AbUIORzX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 13:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267184AbUIORxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 13:53:30 -0400
Received: from pop.gmx.net ([213.165.64.20]:64474 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S267223AbUIORxF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 13:53:05 -0400
X-Authenticated: #1725425
Date: Wed, 15 Sep 2004 20:03:11 +0200
From: Marc Ballarin <Ballarin.Marc@gmx.de>
To: taeuber@informatik.hu-berlin.de
Cc: lars.taeuber@gmx.net, axboe@suse.de, linux-kernel@vger.kernel.org,
       B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Re: cdrom recognition on kernel 2.6.8.1
Message-Id: <20040915200311.5c8b2c83.Ballarin.Marc@gmx.de>
In-Reply-To: <20040915191532.246dc6ca.lars.taeuber@gmx.net>
References: <20040915093635.1a8f08ff.taeuber@bbaw.de>
	<20040915085939.GU2304@suse.de>
	<20040915191532.246dc6ca.lars.taeuber@gmx.net>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Sep 2004 19:15:32 +0200
Lars Täuber <lars.taeuber@gmx.net> wrote:

> ...
> 
> As written bevore the drive is not recognised only with an audio cd in
> it.
> 

I've seen Teac drives blocking the Windows XP boot process when
certain discs are inserted. There were even freezes when copying files to
hard disk that did not occur when a different drive was used.
(Wasn't my machine, can't test anything.)

Obviously Teac's firmware has some issues.

Regards
