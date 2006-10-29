Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964973AbWJ2DoA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964973AbWJ2DoA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 23:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964974AbWJ2DoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 23:44:00 -0400
Received: from web36709.mail.mud.yahoo.com ([209.191.85.43]:2230 "HELO
	web36709.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964973AbWJ2DoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 23:44:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=WFUOcxoECkfnAZfc8mldeUwe5d/8yRTreKCi9bp8FXvSJvlGPowV6Ocf04cp0R3IyZozD1yRaSej/kp/Zdv8urRoRSQLNSibGo9lgckjm/iaablNRckz71tR1Jp9a1eBRjv+YbBrZabhJHu2WJ662i25MDh7szezuoJndZrN06k=  ;
Message-ID: <20061029034359.25131.qmail@web36709.mail.mud.yahoo.com>
Date: Sat, 28 Oct 2006 20:43:59 -0700 (PDT)
From: Alex Dubov <oakad@yahoo.com>
Subject: Re: [2.6.19-rc2-mm2] oops removing sd card
To: Pierre Ossman <drzeus-mmc@drzeus.cx>
Cc: Fabio Comolli <fabio.comolli@gmail.com>,
       kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <45431257.8080401@drzeus.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I know that this is unfortunate, but I, currently, don't have an ability to put 2.6.19 kernel on a
machine with ti controller. I have not seen this problem on 2.6.18, so I'm out of ideas.

--- Pierre Ossman <drzeus-mmc@drzeus.cx> wrote:

> Fabio Comolli wrote:
> > More info: I tried to use tifm_core.c and tifm_71xx.c from 2.6.18-mm3
> > with 2.6.19-rc2-mm2 and the crash also happens.
> > 
> 
> Alex, have you followed up this? I haven't seen any replies.
> 
> Rgds
> -- 
>      -- Pierre Ossman
> 
>   Linux kernel, MMC maintainer        http://www.kernel.org
>   PulseAudio, core developer          http://pulseaudio.org
>   rdesktop, core developer          http://www.rdesktop.org
> 



 
____________________________________________________________________________________
Access over 1 million songs - Yahoo! Music Unlimited 
(http://music.yahoo.com/unlimited)

