Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267368AbUIJLVb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267368AbUIJLVb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 07:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267356AbUIJLVb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 07:21:31 -0400
Received: from 217-114-210-112.kunde.vdserver.de ([217.114.210.112]:57357 "EHLO
	old-fsckful.ath.cx") by vger.kernel.org with ESMTP id S267368AbUIJLV3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 07:21:29 -0400
Date: Fri, 10 Sep 2004 13:21:08 +0200
From: Andreas Happe <andreashappe@flatline.ath.cx>
To: Andreas Happe <crow@old-fsckful.ath.cx>
Cc: Michal Ludvig <michal@logix.cz>, cryptoapi@lists.logix.cz,
       linux-kernel@vger.kernel.org, James Morris <jmorris@redhat.com>
Subject: Re: [cryptoapi/sysfs] display cipher details in sysfs
Message-ID: <20040910112108.GA6613@final-judgement.ath.cx>
References: <20040831175449.GA2946@final-judgement.ath.cx> <Xine.LNX.4.44.0409010043020.30561-100000@thoron.boston.redhat.com> <20040901082819.GA2489@final-judgement.ath.cx> <Pine.LNX.4.53.0409061847000.25698@maxipes.logix.cz> <20040907143509.GA30920@old-fsckful.ath.cx> <Pine.LNX.4.53.0409071659070.19015@maxipes.logix.cz> <20040907165755.GA32032@old-fsckful.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20040907165755.GA32032@old-fsckful.ath.cx>
X-Request-PGP: subkeys.pgp.net
X-Hangover: none
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Happe <crow@old-fsckful.ath.cx> [040910 12:44]:
>On Tue, Sep 07, 2004 at 05:49:14PM +0200, Michal Ludvig wrote:
>
>> This is a compile time thing, e.g. something like:
>> 	.cia_min_keysize = 1,
>> 	.cia_max_keysize = 128
>> for variable keysizes, and
>> 	.cia_keysizes = { 128, 192, 256, -1 }
>> for discrete keysizes.
>> typeof(cia_keysizes) would be "int[]".
>
>can do, but see james morris other patch.

*argh*

s/patch/post/

	--Andreas
