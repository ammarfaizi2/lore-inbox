Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319232AbSHNGpR>; Wed, 14 Aug 2002 02:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319233AbSHNGpR>; Wed, 14 Aug 2002 02:45:17 -0400
Received: from ns.suse.de ([213.95.15.193]:43276 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S319232AbSHNGpQ>;
	Wed, 14 Aug 2002 02:45:16 -0400
Date: Wed, 14 Aug 2002 08:49:08 +0200
From: Dave Jones <davej@suse.de>
To: Brad Chapman <jabiru_croc@yahoo.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: What patches I need for s stable 2.5.x
Message-ID: <20020814084908.A28385@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Brad Chapman <jabiru_croc@yahoo.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
References: <1028846060.28882.105.camel@irongate.swansea.linux.org.uk> <20020808233926.14381.qmail@web40005.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020808233926.14381.qmail@web40005.mail.yahoo.com>; from jabiru_croc@yahoo.com on Thu, Aug 08, 2002 at 04:39:26PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2002 at 04:39:26PM -0700, Brad Chapman wrote:
 >         ACK. Are there any gotchas associated with the 2.5.x-dj tree? I 
 > haven't really studied it up to this point.

The biggest gotcha right now is that it's lagging behind mainline.
(Current is 2.5.30-dj1, which doesn't actually boot..
 Last working one was against 2.5.27)

Hopefully I'll be back on track by the end of the week.

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
