Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261793AbVBPTg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbVBPTg2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 14:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261762AbVBPTg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 14:36:28 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:43979 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261756AbVBPTgZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 14:36:25 -0500
Date: Wed, 16 Feb 2005 20:32:58 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: shishir verma <shishir.lkml@gmail.com>
Cc: Paulo Marques <pmarques@grupopie.com>,
       Felipe W Damasio <felipewd@terra.com.br>, a.hocquel@oreka.com,
       linux-kernel@vger.kernel.org
Subject: Re: strange bug with realtek 8169 card
Message-ID: <20050216193258.GA18105@electric-eye.fr.zoreil.com>
References: <3xSPL-6F2-55@gated-at.bofh.it> <3y6g1-KN-23@gated-at.bofh.it> <42138AA5.3040506@oreka.com> <20050216181949.GA17159@electric-eye.fr.zoreil.com> <42139203.3070903@terra.com.br> <421396A4.2060009@grupopie.com> <451d804b050216112640f5c662@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <451d804b050216112640f5c662@mail.gmail.com>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

shishir verma <shishir.lkml@gmail.com> :
> by any chance is the watchdog enabled for the card...because i had a
> similar problem with a broadcom gigabit card....i commented the
> watchdog code and made the module again...
> it worked like a charm for me after that...

The original user wrote:
[...]
> > If I look in every log file I can (dmesg, kernel.log, syslog, debug)
> > there is no message...

-> the watchdog would have caused something to appear.

I'd rather have a bit more information before resorting to super-voodoo.

--
Ueimor
