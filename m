Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751537AbWIBUi2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751537AbWIBUi2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 16:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751538AbWIBUi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 16:38:27 -0400
Received: from z2.cat.iki.fi ([212.16.98.133]:30407 "EHLO z2.cat.iki.fi")
	by vger.kernel.org with ESMTP id S1751536AbWIBUi1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 16:38:27 -0400
Date: Sat, 2 Sep 2006 23:38:25 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Grant Coady <gcoady.lk@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: "VGER BF report:.." ?
Message-ID: <20060902203825.GG16047@mea-ext.zmailer.org>
References: <20060901015818.42767813.akpm@osdl.org> <3tkhf2p4f1n1s7ancfmclrlijvne8nhoit@4ax.com> <20060901183927.eba8179d.akpm@osdl.org> <muuhf21hgb5a5vdpdb7i9nds6t5cokqihf@4ax.com> <alpjf21oipfatq83147kkad77l53rf54vs@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpjf21oipfatq83147kkad77l53rf54vs@4ax.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 03, 2006 at 06:20:01AM +1000, Grant Coady wrote:
> On Sat, 02 Sep 2006 13:51:04 +1000, Grant Coady <gcoady.lk@gmail.com> wrote:
> >-- 
> >VGER BF report: H 6.04481e-06
>                  ^^^^^^^^^^^^^--> perhaps whoever is adding this info-gem 
> can add a sane sprintf?  The boggle minds ;)
> 
> Grant.
> -- 
> VGER BF report: H 0.00423726

  That is  "bogofilter -T" giving that result.
Presently it is there to debug things and to see what leaked
(unrecognized) spams got..   But my intention is to remove it
quite soon -- say, on monday.

   /Matti Aarnio  -- one of <postmaster@vger.kernel.org>

-- 
VGER BF report: U 0.5
