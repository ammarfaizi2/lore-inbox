Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932207AbWCRPBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbWCRPBK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 10:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbWCRPBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 10:01:10 -0500
Received: from main.gmane.org ([80.91.229.2]:46546 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932207AbWCRPBJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 10:01:09 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andras Mantia <amantia@kde.org>
Subject: Re: [PATCH 001/001] PCI: PCI quirk for Asus A8V and A8V Deluxe motherboards
Date: Sat, 18 Mar 2006 17:00:44 +0200
Message-ID: <dvh7aj$95v$1@sea.gmane.org>
References: <20060305192709.GA3789@skyscraper.unix9.prv> <dve3j9$r50$1@sea.gmane.org> <20060317143303.GR20746@lug-owl.de> <dvehv7$j9r$1@sea.gmane.org> <20060317144920.GS20746@lug-owl.de> <dveugj$aob$1@sea.gmane.org> <yw1xmzfo98em.fsf@agrajag.inprovide.com> <dvh3rb$ui8$1@sea.gmane.org> <yw1x64mb7rwm.fsf@agrajag.inprovide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 84.247.48.167
User-Agent: KNode/0.10.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Måns Rullgård wrote:
> With the card in the bad slot I only got a few seconds of sound before
> the machine locked up.  Since you have a different board, it could of
> course still be a similar problem, just less likely to happen.
> 
> Which sound card were you using when your machine hung?

I tried to use the onboard sound card at that time.

>> Can you tell me how can I find the real device ID for my chipset? It
>> *should* be the same one as the original writer of the patch wrote (he
>> also had an ASUS A8V Deluxe as I understood), but the experience tells it
>> is not.
> 
> lspci -n will list the PCI IDs in hex.


Thanks.

Andras 

-- 
Quanta Plus developer - http://quanta.kdewebdev.org
K Desktop Environment - http://www.kde.org


