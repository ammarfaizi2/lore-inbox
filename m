Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261475AbUCKRvD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 12:51:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261614AbUCKRvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 12:51:03 -0500
Received: from mailr-2.tiscali.it ([212.123.84.82]:19835 "EHLO
	mailr-2.tiscali.it") by vger.kernel.org with ESMTP id S261475AbUCKRvA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 12:51:00 -0500
X-BrightmailFiltered: true
Date: Thu, 11 Mar 2004 18:51:09 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: linux-kernel@vger.kernel.org
Cc: Damian Kolkowski <damian@kolkowski.no-ip.org>
Subject: Re: [i386] 2.6.4 + cdrtools-2.01a27 REPORT
Message-ID: <20040311175109.GA2467@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040311162303.ALLYOURBASEAREBELONGTOUS.B29383@kolkowski.no-ip.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Damian Kolkowski <damian@kolkowski.no-ip.org> ha scritto:
> * pinotj@club-internet.fr <pinotj@club-internet.fr> [2004-03-11 16:32]:
>> I post this because I think it will maybe help some people that want to
>> switch to a 2.6 and burn some CD quickly.
> 
> For me 2.6.x is useles, because freambuffer lack my radeon (rv25if),

Which driver are you using? This card should be supported by the new
driver (and afaics also from the old one). If the new driver doesn't
work for you can you send me a "lspci -nvvv" of your board?

thanks,
Luca
-- 
Home: http://kronoz.cjb.net
Tentare e` il primo passo verso il fallimento.
Homer J. Simpson
