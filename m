Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750945AbWEVQPi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbWEVQPi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 12:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750942AbWEVQPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 12:15:38 -0400
Received: from enyo.dsw2k3.info ([195.71.86.239]:6051 "EHLO enyo.dsw2k3.info")
	by vger.kernel.org with ESMTP id S1750913AbWEVQPh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 12:15:37 -0400
Message-ID: <4471E39C.1070003@citd.de>
Date: Mon, 22 May 2006 18:15:24 +0200
From: Matthias Schniedermeyer <ms@citd.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217 Mnenhy/0.7
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christian Trefzer <ctrefzer@gmx.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jan Knutar <jk-lkml@sci.fi>,
       Pau Garcia i Quiles <pgquiles@elpauer.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [IDEA] Poor man's UPS
References: <200605212131.47860.pgquiles@elpauer.org> <20060521224012.GB30855@hermes.uziel.local> <200605221604.16043.jk-lkml@sci.fi> <20060522151303.GA4538@hermes.uziel.local> <1148312458.17376.54.camel@localhost.localdomain> <20060522154830.GA5344@hermes.uziel.local>
In-Reply-To: <20060522154830.GA5344@hermes.uziel.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Trefzer wrote:
> On Mon, May 22, 2006 at 04:40:58PM +0100, Alan Cox wrote:
> 
>>Lead acid batteries should be kept well charged to avoid sulphation and
>>always full charged when recharging, preferably using a charger that
>>will do proper three step charging. "Cycling" a lead acid battery is a
>>great way to destroy it.
>>
> 
> 
> So it is better to use only one battery (or an array thereof) which is
> sort of charged and discharged at the same time, or is this idea just as
> screwed..? I don't have a degree in electronics, mind you : )
> 
> Might be easier to build something that keeps a battery well maintained
> and switches in case of power outage. With large enough condensors to
> bridge the gap, which would also iron out any peaks and stuff, this
> should work pretty well.

You just described the working-principle of a "line-interarctive" UPS.
AFAICT this is the most used UPS-type, at least for every "small" UPSes 
i've seen in the last few years.




Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated,
cryptic, powerful, unforgiving, dangerous.

