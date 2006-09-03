Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932074AbWICT71@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbWICT71 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 15:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932075AbWICT71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 15:59:27 -0400
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:22992 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S932074AbWICT71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 15:59:27 -0400
From: Grant Coady <gcoady.lk@gmail.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Matti Aarnio <matti.aarnio@zmailer.org>, linux-kernel@vger.kernel.org
Subject: Re: "VGER BF report:.." ?
Date: Mon, 04 Sep 2006 05:59:23 +1000
Organization: http://bugsplatter.mine.nu/
Reply-To: Grant Coady <gcoady.lk@gmail.com>
Message-ID: <8fcmf2pp70psbmac3sgvucv90jlk58qgud@4ax.com>
References: <20060901015818.42767813.akpm@osdl.org> <3tkhf2p4f1n1s7ancfmclrlijvne8nhoit@4ax.com> <20060901183927.eba8179d.akpm@osdl.org> <muuhf21hgb5a5vdpdb7i9nds6t5cokqihf@4ax.com> <alpjf21oipfatq83147kkad77l53rf54vs@4ax.com> <20060902203825.GG16047@mea-ext.zmailer.org> <Pine.LNX.4.61.0609031705170.13319@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0609031705170.13319@yvahk01.tjqt.qr>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Sep 2006 17:06:27 +0200 (MEST), Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:

>
>>> >-- 
>>> >VGER BF report: H 6.04481e-06
>>>                  ^^^^^^^^^^^^^--> perhaps whoever is adding this info-gem 
>>> can add a sane sprintf?  The boggle minds ;)
>
>Sane? That's just sprintf("%e") - simple, is not it?

Not my point.  The value could be rounded to 2 or three digit value for 
display, perhaps a 2 digit percentage?  The example may as well be zero.

Grant.

-- 
VGER BF report: H 0.126501
