Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264026AbRFROTg>; Mon, 18 Jun 2001 10:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264050AbRFROT0>; Mon, 18 Jun 2001 10:19:26 -0400
Received: from viper.haque.net ([66.88.179.82]:38354 "EHLO mail.haque.net")
	by vger.kernel.org with ESMTP id <S264026AbRFROTH>;
	Mon, 18 Jun 2001 10:19:07 -0400
Date: Mon, 18 Jun 2001 10:18:49 -0400 (EDT)
From: "Mohammad A. Haque" <mhaque@haque.net>
To: Anuradha Ratnaweera <anuradha@bee.lk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Unresolved symbol do_softirq in 2.4.6-pre3
In-Reply-To: <20010618191709.A711@bee.lk>
Message-ID: <Pine.LNX.4.33.0106181017300.6188-100000@viper.haque.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jun 2001, Anuradha Ratnaweera wrote:

> I started running 2.4.6-pre3 using the same configuration file as 2.4.5.
> Diff shows no effective differences between two config files.
>
> depmod complains unresolved symbols (do_softirq) in ppp_generic, ppp_async
> and sunrpc.
>

Please check the list archives. A possible solution was posted by Keith
owens
<http://marc.theaimsgroup.com/?l=linux-kernel&m=99245070328459&w=2>.

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================

