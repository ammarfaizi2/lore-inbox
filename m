Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268271AbUI2Iko@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268271AbUI2Iko (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 04:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268274AbUI2Iko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 04:40:44 -0400
Received: from 217-114-210-112.kunde.vdserver.de ([217.114.210.112]:42249 "EHLO
	old-fsckful.ath.cx") by vger.kernel.org with ESMTP id S268271AbUI2Ikl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 04:40:41 -0400
Date: Wed, 29 Sep 2004 10:40:32 +0200
From: Andreas Happe <andreashappe@flatline.ath.cx>
To: Sven Schuster <schuster.sven@gmx.de>
Cc: James Morris <jmorris@redhat.com>, cryptoapi@lists.logix.cz,
       Michal Ludvig <michal@logix.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.9-rc2 2/2] cryptoapi: make /proc/crypto optional
Message-ID: <20040929084032.GA3969@final-judgement.ath.cx>
References: <20040927084149.GA3625@final-judgement.ath.cx> <Xine.LNX.4.44.0409271151500.21876-100000@thoron.boston.redhat.com> <20040928122117.GA21010@final-judgement.ath.cx> <20040928122332.GB21010@final-judgement.ath.cx> <20040928143211.GA18136@zion.homelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040928143211.GA18136@zion.homelinux.com>
X-Request-PGP: subkeys.pgp.net
X-Hangover: none
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sven Schuster <schuster.sven@gmx.de> [040929 09:17]:
>
>Hi Andreas,
>
>just one little thing I noticed:

thanks,

>> +	  When in double say Y.
>
>In double?? Probably should be "in doubt"...

*blink* ähm.. updated patch can be found at:
http://snikt.net/kernel/patch-2.6.9-rc2-make_proc_crypto_optional-2

	--Andreas
