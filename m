Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131345AbRCWT2l>; Fri, 23 Mar 2001 14:28:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131365AbRCWT2c>; Fri, 23 Mar 2001 14:28:32 -0500
Received: from [193.120.246.5] ([193.120.246.5]:13977 "EHLO best.eurologic.com")
	by vger.kernel.org with ESMTP id <S131345AbRCWT2W>;
	Fri, 23 Mar 2001 14:28:22 -0500
Message-ID: <3ABBA330.2ADCEBAA@eurologic.com>
Date: Fri, 23 Mar 2001 19:25:36 +0000
From: Mark Mitchell <mmitchell@eurologic.com>
Organization: Eurologic
X-Mailer: Mozilla 4.72 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: raw access and qlogic isp device driver?
In-Reply-To: <E14gUgZ-00050U-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>
> ...
>
> > Has anyone used the raw device with qlogicisp driver? Does 
> > anyone have any interest in looking at this?
> 
> It shouldnt matter which driver is involved, but 2.4 raw stuff 
> is reported broken still

Any chance of anyone elaborating on any RAWIO flaws?

*Seems* to work fine with:
- 2.4.2 (inc Dave Miller's zero copy patch)
- qlogic fc driver & qla2200
- PIII
- Seagate ST39103fc drives in a JBOD

I really need to know any *specific* issues with RAWIO.

Cheers,
	Mark.
