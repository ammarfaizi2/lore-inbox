Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750958AbWEVQS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750958AbWEVQS6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 12:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbWEVQS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 12:18:58 -0400
Received: from c-67-177-35-222.hsd1.ut.comcast.net ([67.177.35.222]:25728 "EHLO
	ns1.utah-nac.org") by vger.kernel.org with ESMTP id S1750955AbWEVQS5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 12:18:57 -0400
Message-ID: <4471EF73.1030100@wolfmountaingroup.com>
Date: Mon, 22 May 2006 11:05:55 -0600
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christian Trefzer <ctrefzer@gmx.de>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jan Knutar <jk-lkml@sci.fi>,
       Pau Garcia i Quiles <pgquiles@elpauer.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [IDEA] Poor man's UPS
References: <200605212131.47860.pgquiles@elpauer.org> <20060521224012.GB30855@hermes.uziel.local> <200605221604.16043.jk-lkml@sci.fi> <20060522151303.GA4538@hermes.uziel.local> <1148312458.17376.54.camel@localhost.localdomain> <20060522154830.GA5344@hermes.uziel.local>
In-Reply-To: <20060522154830.GA5344@hermes.uziel.local>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Trefzer wrote:

>On Mon, May 22, 2006 at 04:40:58PM +0100, Alan Cox wrote:
>  
>
>>Lead acid batteries should be kept well charged to avoid sulphation and
>>always full charged when recharging, preferably using a charger that
>>will do proper three step charging. "Cycling" a lead acid battery is a
>>great way to destroy it.
>>
>>    
>>
>
>So it is better to use only one battery (or an array thereof) which is
>sort of charged and discharged at the same time, or is this idea just as
>screwed..? I don't have a degree in electronics, mind you : )
>
>Might be easier to build something that keeps a battery well maintained
>and switches in case of power outage. With large enough condensors to
>bridge the gap, which would also iron out any peaks and stuff, this
>should work pretty well.
>
>Kind regards,
>Chris
>  
>
You know, these old lead acid batteries are a fire hazard, not to 
mention they produce free hydrogen gas when discharging to charging.

Guys, stick to nicads or a fuel cell to avoid burning down your house or 
the neighborhood.  Ever see a lead acid battery explode?  I have.  It 
throws sulphuric acid all over the place.

Jeff
