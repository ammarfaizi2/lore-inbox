Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264748AbUFGOvu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264748AbUFGOvu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 10:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264746AbUFGOvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 10:51:32 -0400
Received: from gprs214-178.eurotel.cz ([160.218.214.178]:43648 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S264733AbUFGOv0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 10:51:26 -0400
Date: Mon, 7 Jun 2004 16:51:16 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Sebastian Kloska <kloska@scienion.de>
Cc: Keith Duthie <psycho@albatross.co.nz>, linux-kernel@vger.kernel.org
Subject: Re: APM realy sucks on 2.6.x
Message-ID: <20040607145116.GE1467@elf.ucw.cz>
References: <40C0E91D.9070900@scienion.de> <20040607123839.GC11860@elf.ucw.cz> <40C46F7F.7060703@scienion.de> <Pine.LNX.4.53.0406080228110.27816@loki.albatross.co.nz> <40C47FEE.6080505@scienion.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40C47FEE.6080505@scienion.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  The pure ALSA system with PCI Cirrus Logic CS4281
>  (my configuration) just dropped of my list of
>  the 'bad' one ....
> 
>  Does this bug freeze the machine ? Or just block
>  the outputting program ?
> 
>  PCM will be the next to look at...

Drop all non-important hw. That's everything but keyboard, VGA and
harddrive...

>  +-compile->reboot->check->-+
>  ^                          |
>  |                          |
>  +---<----------------------+
> 
>  Kind of feel like in the old days where
>  a decend 'printf(stderr,....)' was THE
>  state of the art debugging tool ....

Its *still* state of the art debugging tool for kernel.
								Pavel
-- 
934a471f20d6580d5aad759bf0d97ddc
