Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264396AbUEEJ4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264396AbUEEJ4I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 05:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264412AbUEEJ4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 05:56:08 -0400
Received: from mail.tpgi.com.au ([203.12.160.58]:24484 "EHLO mail2.tpgi.com.au")
	by vger.kernel.org with ESMTP id S264396AbUEEJ4D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 05:56:03 -0400
Subject: Re: swsusp documentation updates
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@zip.com.au>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040505094719.GA4259@elf.ucw.cz>
References: <20040505094719.GA4259@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1083750907.17294.27.camel@laptop-linux.wpcb.org.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5-2.norlug 
Date: Wed, 05 May 2004 19:55:07 +1000
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howdy.

On Wed, 2004-05-05 at 19:47, Pavel Machek wrote:
> +There are two solutions to this:
> +
> +* require half of memory to be free during suspend. That way you can
> +read "new" data onto free spots, then cli and copy

Would you consider adding:

(Suspend2, which allows more than half of memory to be saved, is a
variant on this).

Regards,

Nigel
-- 
Nigel & Michelle Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614.
+61 (2) 6251 7727(wk); +61 (2) 6254 0216 (home)

Evolution (n): A hypothetical process whereby infinitely improbable events occur 
with alarming frequency, order arises from chaos, and no one is given credit.

